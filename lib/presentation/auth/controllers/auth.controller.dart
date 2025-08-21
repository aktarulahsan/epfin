import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epfin/infrastructure/dal/model/login.model.dart';
import 'package:epfin/infrastructure/dal/model/user.model.dart';
import 'package:epfin/infrastructure/dal/services/auth.service.dart';
import 'package:epfin/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/main.dart';
import 'package:epfin/presentation/home/home.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/dal/model/base_response.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var obscurePassword = true.obs;
  var isLoading = false.obs;
  final RxString error = ''.obs;
  var userLists = <String>[].obs;
  var checkUserMail = ''.obs;

  @override
  void onInit() {
    email.value.text = prefs.getString('mail') ?? "";
    super.onInit();
  }


  Future<void> getStatusList() async {
    await AuthService.getUserList().then((value) async {
      try {
        BaseResponse responses = BaseResponse.fromJson(value.data);

        if (responses.dataList != null) {
          userLists.value = responses.dataList!
              .map((e) => e['email'].toString())
              .cast<String>()
              .toList();
        }
      } catch (e) {
        print("Error parsing user list: $e");
      }
    });
  }

  Future<void> checkUser() async {
   await getStatusList();
    final match = userLists.value.firstWhere(
          (v) => v == email.value.text.trim(),
      orElse: () => '', // return empty if not found
    );

    checkUserMail.value = match;
    checkLoginStatus();
  }



  void checkLoginStatus() async {

    LoginModel m = LoginModel();
    var a = prefs.get('userInfo');

    if (a != null) {
      m = loginResponseFromJson(a.toString());
    }

    if (checkUserMail.value.isNotEmpty) {
      await AuthService.logIn(email.value.text, password.value.text)
          .then((value) async {
            BaseResponse responses = BaseResponse.fromJson(value.data);

            if (responses.data != null) {
              LoginModel user = LoginModel.fromJson(responses.data);

              prefs.remove("userInfo");
              prefs.setString('userInfo', jsonEncode(responses.data));

              if (user.ischangePassword == false) {
                Get.offAllNamed(Routes.FORGOTPASSWORD);
              } else {
                Get.offAll(HomeScreen(), binding: HomeControllerBinding());
              }
            } else {
              // Login failed
              Get.snackbar(
                "Login Failed",
                "Invalid email or password",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red.withOpacity(0.8),
                colorText: Colors.white,
                margin: const EdgeInsets.all(10),
              );
            }
          })
          .catchError((error) {
            // Error occurred
            Get.snackbar(
              "Error",
              "Something went wrong. Please try again.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.withOpacity(0.8),
              colorText: Colors.white,
              margin: const EdgeInsets.all(10),
            );
          });
    } else {
      signIn();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signIn() async {
    isLoading.value = true;
    error.value = '';
    try {
      // Firebase Authentication
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.value.text.trim(),
        password: password.value.text.trim(),
      );
      User? signedInUser = result.user;

      if (signedInUser != null) {
        // Fetch user document from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(signedInUser.uid).get();

        if (userDoc.exists) {
          // Convert Firestore data to UserModel
          UserModel user = UserModel.fromJson(
            userDoc.data() as Map<String, dynamic>,
          );

          // Save user info locally (SharedPreferences / GetStorage / Hive)

          LoginModel loginModel = LoginModel(
            u: user.uid,
            email: user.email,
            name: user.name,
            companyName: user.companyName,
            role: user.role,
            userTypeName: 'web', // Assuming role is used as userTypeName
          );

          prefs.setString('userInfo', jsonEncode(loginModel.toJson()));

          print("✅ User stored locally: ${user.email}");
        } else {
          print("❌ User document not found in Firestore");
        }

        // Navigate to Home
        Get.offAll(HomeScreen(), binding: HomeControllerBinding());

        clearFields();
      }
    } on FirebaseAuthException catch (e) {
      error.value = e.message ?? 'An unknown error occurred.';
    } catch (e) {
      error.value = 'Failed to sign in. Please try again.';
      print("❌ General error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  void clearFields() {
    email.value.clear();
    password.value.clear();
  }
}

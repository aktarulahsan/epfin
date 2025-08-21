import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epfin/infrastructure/dal/model/login.model.dart';
import 'package:epfin/infrastructure/dal/model/user.model.dart';
import 'package:epfin/infrastructure/dal/services/registration.service.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  //TODO: Implement RegistrationController

  var email = TextEditingController().obs;
  var name = TextEditingController().obs;
  var password = TextEditingController().obs;
  var confirmPassword = TextEditingController().obs;
  var companyName = TextEditingController().obs;
  var usertype = TextEditingController().obs;
  var isLoading = false.obs;
  // var selectedRole = ''.obs;
  var selectedRole = RxnString();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> register() async {
    isLoading.value = true;

    var mail = email.value.text;
    var pass = password.value.text;
    var uName = name.value.text;
    var company = companyName.value.text;
    // int userType = selectedRole.value = 'CFO' ? 1 : 2;
    int userType = selectedRole.value == 'CFO' ? 1 : 2;
    try {
      await RegistrationService.registration(
            name: uName,
            email: mail,
            password: pass,
            userType: userType,
            companyName: company,
          )
          .then((response) {
            if (response.statusCode == 200) {
              // Handle successful registration
              Get.defaultDialog(
                title: "Success",
                middleText: "Registration successful!",
                textConfirm: "OK",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back(); // Close dialog
                  Get.offAllNamed(Routes.AUTH);
                },
              );
            } else {
              // Handle error response
              Get.defaultDialog(
                title: "Error",
                middleText: "Registration failed. Please try again.",
                textConfirm: "OK",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back(); // Close dialog
                },
              );
            }
          })
          .catchError((error) {
            // Handle any exceptions that occur during the registration process
            Get.defaultDialog(
              title: "Error",
              middleText: "An error occurred: $error",
              textConfirm: "OK",
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back(); // Close dialog
              },
            );
          });
    } catch (e) {
      // Handle any exceptions that occur during the registration process
      // Get.defaultDialog(
      //   title: "Error",
      //   middleText: "An error occurred: $e",
      //   textConfirm: "OK",
      //   confirmTextColor: Colors.white,
      // );
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reactive user state
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;

  var role = ['Admin', 'Viewer', 'Editor'].obs;
  var selectRole = 'Admin'.obs;
  final RxString error = ''.obs;
  // final RxBool isLoading = false.obs;

  Future<void> signUp() async {
    // ... (existing signUp code remains the same)
    isLoading.value = true;
    error.value = '';
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.value.text.trim(),
        password: password.value.text.trim(),
      );
      User? newUser = result.user;

      if (newUser != null) {
        UserModel userModel = UserModel(
          uid: newUser.uid,
          email: newUser.email!,
          name: name.value.text.trim(),
          companyName: companyName.value.text.trim(),
          role: selectRole.value,
        );
        await _firestore
            .collection('users')
            .doc(newUser.uid)
            .set(userModel.toJson());
        await _firestore
            .collection('companies')
            .doc(userModel.companyName)
            .collection('users')
            .doc(newUser.uid)
            .set({
              'email': userModel.email,
              'name': userModel.name,
              'role': userModel.role,
              'uid': newUser.uid,
              'companyName': userModel.companyName,
            });
      }
      clearFields();
    } on FirebaseAuthException catch (e) {
      error.value = e.message ?? 'An unknown error occurred.';
    } catch (e) {
      error.value = 'Failed to sign up. Please try again.';
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    email.value.clear();
    password.value.clear();
    companyName.value.clear();
    error.value = '';
    selectRole.value = 'Admin';
  }

  /// Sets the user's role.
  void setRole(String newRole) {
    selectRole.value = newRole;
  }
}

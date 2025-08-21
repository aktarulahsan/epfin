import 'dart:convert';

import 'package:epfin/infrastructure/dal/model/login.model.dart';
import 'package:epfin/infrastructure/dal/model/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import 'package:intl/intl.dart';

import '../../../main.dart';

class CreateUserController extends GetxController {
  //TODO: Implement CreateUserController

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final newUserEmailController = TextEditingController();
  final newUserPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RxString role = 'viewer'.obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final List<String> roles = ['Viewer', 'Editor'];

  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;
  final Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  var userInfo = LoginModel().obs;

  @override
  void onInit() {
    super.onInit();
    // _firebaseUser.bindStream(_auth.authStateChanges());

    userInfo.value = LoginModel.fromJson(
      jsonDecode(prefs.getString('userInfo') ?? '{}'),
    );

    // ever(_firebaseUser, _setInitialScreen);
  }

  // _setInitialScreen(User? user) {
  //   if (user != null) {
  //     firestoreUser.bindStream(streamFirestoreUser());
  //     ever(firestoreUser, (_) => fetchTodaysLoanData());
  //   } else {
  //     todaysLoanData.value = null;
  //   }
  // }

  void setRole(String? newRole) {
    if (newRole != null) {
      role.value = newRole;
    }
  }


  Future<bool> createUserInCompany({required String email, required String password, required String role}) async {
    if (userInfo.value== null) {
      error.value = "Could not identify the admin's company.";
      return false;
    }

    // Note: This client-side approach has limitations. For production,
    // creating users via a Cloud Function is more secure and robust.

    bool success = false;
    try {
      // Temporarily create the new user. This will sign out the admin.
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? newUser = result.user;

      if (newUser != null) {
        UserModel userModel = UserModel(
          uid: newUser.uid,
          email: newUser.email!,
          companyName: userInfo.value.companyName!, // Use admin's company
          role: role,
          name: nameController.text,
        );

        // Save the new user's data to Firestore
        await firestore.collection('users').doc(newUser.uid).set(userModel.toJson());
        await firestore.collection('companies').doc(userModel.companyName).collection('users').doc(newUser.uid).set({
          // 'email': userModel.email,
          // 'role': userModel.role,
          'email': userModel.email,
          'name': userModel.name,
          'role': userModel.role,
          'uid': newUser.uid,
          'companyName': userModel.companyName,
        });

        // IMPORTANT: Re-authenticate the admin user.
        // We sign out the newly created user and sign the admin back in.
        // await _auth.signOut();
        // await signIn(
        //     email: firestoreUser.value!.email,
        //
        //     password: passwordController.text.trim() // Placeholder
        // );

        success = true;
      }
    } on FirebaseAuthException catch (e) {
      error.value = e.message ?? 'An unknown error occurred.';
    } catch (e) {
      error.value = 'Failed to create user. Please try again.';
      print(e);
    }
    return success;
  }

  Future<void> createUser() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      error.value = '';

      final success = await createUserInCompany(
        email: newUserEmailController.text.trim(),
        password: newUserPasswordController.text.trim(),
        role: role.value,
      );

      if (success) {
        // Navigate back and show a success message if creation is successful
        Get.back();
        Get.snackbar(
          "Success",
          "New user created for ${firestoreUser.value?.companyName}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Error is already set by the authController, just update loading state
        error.value = error.value;
      }

      isLoading.value = false;
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

}

import 'package:epfin/infrastructure/dal/services/registration.service.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
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
                onConfirm: (){
                  Get.back(); // Close dialog
                }
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
                onConfirm: (){
                  Get.back(); // Close dialog
                }
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
}

import 'package:epfin/infrastructure/dal/model/base_response.dart';
import 'package:epfin/infrastructure/dal/services/change_password.service.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

  var oldPasswordCtrl = TextEditingController().obs;
  var newPasswordCtrl = TextEditingController().obs;
  var new1PasswordCtrl = TextEditingController().obs;
  var isLoading = 0.obs;

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

  Future<void> changePassword() async {
    isLoading.value = 1;

    var mail = prefs.getString('mail') ?? "";
    var oldPass = oldPasswordCtrl.value.text;
    var newPass = newPasswordCtrl.value.text;
    var confirmPass = new1PasswordCtrl.value.text;

    await ChangePasswordService.changePassword(
          email: mail,
          oldPassword: oldPass,
          newPassword: newPass,
          confirmPassword: confirmPass,
        )
        .then((value) async {
          BaseResponse responses = BaseResponse();
          try {
            responses = BaseResponse.fromJson(value.data);
            if (responses.success == true) {
              Get.defaultDialog(
                title: "Success",
                middleText: "Password submitted successfully!",
                textConfirm: "OK",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back(); // Close dialog
                  Get.offNamed(Routes.HOME); // Navigate back to HomeScreen
                },
              );
            } else {
              Get.defaultDialog(
                title: "Warning",
                middleText: responses.message ?? "Something went wrong!",
                textConfirm: "OK",
                confirmTextColor: Colors.white,
                onConfirm: () => Get.back(),
              );
            }
          } catch (e) {
            print("Parse Error: $e");
            Get.defaultDialog(
              title: "Warning",
              middleText: "Invalid server response.",
              textConfirm: "OK",
              confirmTextColor: Colors.white,
              onConfirm: () => Get.back(),
            );
          } finally {
            isLoading.value = 0;
          }
        })
        .catchError((e) {
          isLoading.value = 0;
          print("Submit Error: $e");
          Get.defaultDialog(
            title: "Warning",
            middleText: "Failed to submit data.",
            textConfirm: "OK",
            confirmTextColor: Colors.white,
            onConfirm: () => Get.back(),
          );
        });
  }
}

import 'dart:convert';

import 'package:epfin/infrastructure/dal/model/base_response.dart';
import 'package:epfin/infrastructure/dal/model/login.model.dart';
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
  var user = LoginModel().obs;

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

    user.value = LoginModel.fromJson(
      jsonDecode(prefs.getString('userInfo') ?? '{}'),
    );
    if (user == null) {
      Get.snackbar(
        "Error",
        "User information not found",
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    // print("User password: ${user.value.password}");
    // if (oldPass != user.value.password) {
    //   Get.snackbar(
    //     "Error",
    //     "Old password is incorrect",
    //     backgroundColor: Colors.red.withOpacity(0.7),
    //     colorText: Colors.white,
    //   );
    //   return;
    // }

    // 2. Check new password match
    if (newPass != confirmPass) {
      Get.snackbar(
        "Error",
        "New password and Confirm password do not match",
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    await ChangePasswordService.changePassword(
      email: mail,
      oldPassword: oldPass,
      newPassword: newPass,
      confirmPassword: confirmPass,
    ).then((value) async {
      BaseResponse responses = BaseResponse();
      try {
        responses = BaseResponse.fromJson(value.data);
        if (responses.success == true) {
          showResponseDialog(
            title: "Success",
            message: "Password submitted successfully!",
            type: 0,
            onConfirm: () {
              Get.back(); // close dialog
              Get.offNamed(Routes.HOME); // go to HomeScreen
            },
          );
        } else {
          showResponseDialog(
            title: "Warning",
            message: responses.message ?? "Something went wrong!",
            type: 1,
            onConfirm: () => Get.back(),
          );
        }
      } catch (e) {
        print("Parse Error: $e");
        showResponseDialog(
          title: "Error",
          message: "Invalid server response.",
          type: 2,
          onConfirm: () => Get.back(),
        );
      } finally {
        isLoading.value = 0;
      }
    });
  }

  void showResponseDialog({
    required String title,
    required String message,
    required int type, // 0=success, 1=warning, 2=error
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    type == 0
                        ? const Color(0xFF4CAF50)
                        : type == 1
                        ? const Color(0xFFFFC107)
                        : const Color(0xFFF44336),
                child: Icon(
                  type == 0
                      ? Icons.check
                      : type == 1
                      ? Icons.warning
                      : Icons.error,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("OK"),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

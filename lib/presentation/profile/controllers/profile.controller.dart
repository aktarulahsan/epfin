import 'dart:convert';

import 'package:epfin/infrastructure/dal/model/base_response.dart';
import 'package:epfin/infrastructure/dal/model/login.model.dart';
import 'package:epfin/infrastructure/dal/services/auth.service.dart';
import 'package:epfin/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:epfin/main.dart';
import 'package:epfin/presentation/auth/auth.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  var user = LoginModel().obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    var a = await prefs.get('userInfo');
    Map<String, dynamic> userInfo = jsonDecode(
      prefs.getString('userInfo') ?? '{}',
    );

    try {
      if (a != null) {
        user.value = LoginModel.fromJson(userInfo);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteUser() async {
    var a = await prefs.get('userInfo');
    Map<String, dynamic> userInfo = jsonDecode(
      prefs.getString('userInfo') ?? '{}',
    );

    try {
      if (a != null) {
        user.value = LoginModel.fromJson(userInfo);

        await AuthService.deleteUser(user.value.userId)
            .then((response) async {
          BaseResponse responses2 = BaseResponse();

          responses2 = BaseResponse.fromJson(response.data);
          if (response.statusCode == 200) {
            try {
              // Show success snackbar
              Get.snackbar(
                "Success",
                responses2.message ?? "User deleted successfully",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green.withOpacity(0.8),
                colorText: Colors.white,
                margin: const EdgeInsets.all(10),
                duration: const Duration(seconds: 1),
              );

              // Delay a little so user sees the snackbar before navigation
              await Future.delayed(const Duration(seconds: 2));

              Get.offAllNamed(Routes.AUTH); // Navigate to login screen
            } catch (e) {
              print(e.toString());
            }
          } else {
            // Show error snackbar
            Get.snackbar(
              "Error",
              responses2.message ?? "Something went wrong.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.withOpacity(0.8),
              colorText: Colors.white,
              margin: const EdgeInsets.all(10),
            );
          }
        }).catchError((error) {
          // Show error snackbar
          Get.snackbar(
            "Error",
            "Something went wrong. Please try again.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
          );
        });
      }
    } catch (e) {
      print(e.toString());
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

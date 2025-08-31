import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../common/topbar.dart';
import 'controllers/forgotpassword.controller.dart';

class ForgotpasswordScreen extends GetView<ForgotpasswordController> {
  const ForgotpasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomBar(),
      // drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Topbar(title: "Change new Password"),
          ),

          Positioned(
            top: 180,
            left: 10,
            right: 10,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(()=>customText(
                      "Old Password",
                      controller.oldPasswordCtrl.value,
                      isPassword: controller.obscureOldPassword.value,
                      onSuffixPressed: () {
                        controller.obscureOldPassword.value =
                        !controller.obscureOldPassword.value;
                      },
                    ),),
                    const SizedBox(height: 10),
                    Obx(()=>customText(
                      "New Password",
                      controller.newPasswordCtrl.value,
                      isPassword: controller.obscureNewPassword.value,
                      onSuffixPressed: () {
                        controller.obscureNewPassword.value =
                        !controller.obscureNewPassword.value;
                      },
                    ),),
                    const SizedBox(height: 10),
                    Obx(()=>customText(
                      "Confirm Password",
                      controller.new1PasswordCtrl.value,
                      isPassword: controller.obscureConfiremPassword.value,
                      onSuffixPressed: () {
                        controller.obscureConfiremPassword.value =
                        !controller.obscureConfiremPassword.value;
                      },
                    ),),
                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          controller.changePassword();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customText(String title, TextEditingController cont, {bool isPassword = false, VoidCallback? onSuffixPressed, }) {
    // final formatter = NumberFormat.decimalPattern('en_IN');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, ),
          ),
        ),
        Expanded(
          flex: 6,
          child: TextField(
            obscureText: isPassword,
            controller: cont,
            keyboardType:
            TextInputType.text, // Keep text so user can type anything
            style: const TextStyle(color: Colors.black),

            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: onSuffixPressed,   // 👈 Now dynamic
                )
            ),
            onChanged: (value) {
              // Check if value is numeric

              cont.value = TextEditingValue(text: value);
            },

          ),
        ),
      ],
    );
  }
}
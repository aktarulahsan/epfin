import 'package:epfin/presentation/bottomNave/bottom_nave.screen.dart';
import 'package:epfin/presentation/common/bottom_bar.dart';
import 'package:epfin/presentation/common/custom_drawer.dart';
import 'package:epfin/presentation/common/topbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/change_password.controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomBar(),
      bottomNavigationBar: BottomNaveScreen(),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Topbar(title: "Change Password"),
          ),

          Positioned(
            top: 180,
            left: 10,
            right: 10,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    customText(
                      "Old Password",
                      controller.oldPasswordCtrl.value,
                    ),
                    const SizedBox(height: 10),
                    customText(
                      "New Password",
                      controller.newPasswordCtrl.value,
                    ),
                    const SizedBox(height: 10),
                    customText(
                      "Confirm Password",
                      controller.new1PasswordCtrl.value,
                    ),
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

  Widget customText(String title, TextEditingController cont) {
    // final formatter = NumberFormat.decimalPattern('en_IN');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 6,
          child: TextField(
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

import 'package:epfin/presentation/common/bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/navigation/routes.dart';
import '../common/topbar.dart';
import 'controllers/forgotpassword.controller.dart';

class ForgotpasswordScreen extends GetView<ForgotpasswordController> {
  const ForgotpasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAllNamed(Routes.HOME);
        },
        backgroundColor: Colors.blue, // Optional: set background color
        shape: const CircleBorder(), // Ensures it's circular (optional)
        child: const Icon(Icons.home),
      ),
      bottomNavigationBar: BottomBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:  Topbar(title: "Change Password",),
          ),

          Positioned(
              top: 180,
              left: 10,
              right: 10,
              bottom: 0,

              child: Column(
            children: [
              customText("Old Password", controller.oldPasswordCtrl.value),
              SizedBox(height: 10,),
              customText("New Password", controller.newPasswordCtrl.value),
              SizedBox(height: 10,),
              customText("New Password", controller.new1PasswordCtrl.value),
              SizedBox(height: 10,),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // Your submit logic here
                    controller.changePassword();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ))

        ],
      )
    );
  }


  Widget customText(String title, TextEditingController cont) {
    // final formatter = NumberFormat.decimalPattern('en_IN');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
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

              cont.value = TextEditingValue(
                  text:  value,);

              // if (value.isNotEmpty &&
              //     double.tryParse(value.replaceAll(',', '')) != null) {
              //   final number = double.parse(value.replaceAll(',', ''));
              //   cont.value = TextEditingValue(
              //     text:  number,
              //     selection: TextSelection.collapsed(
              //       offset: number,
              //     ),
              //   );
              // }
            },
          ),
        ),
      ],
    );
  }
}

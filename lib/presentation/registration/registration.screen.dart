import 'dart:ui' as ui;

import 'package:epfin/constant/asset_images.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/registration.controller.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetsImages.logo6), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login Form Card with Blur Effect
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ), // Blur effect
                      child: Container(
                        width:
                            MediaQuery.of(context).size.width *
                            0.85, // Match image width
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2762A1).withOpacity(
                            0.4,
                          ), // FF2762A1//#416ba6// Semi-transparent card background
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppAssetsImages.logo, // Logo image
                              height: 40,
                              // color: Colors.white,
                              fit: BoxFit.fill, // White tint to match image
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Registration to EPFIN',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ), // Adjust spacing to match image
                            TextField(
                              // obscureText: true,
                              cursorColor: Colors.white,
                              controller: controller.name.value,
                              decoration: const InputDecoration(
                                labelText: 'Enter Name',
                                fillColor: Colors.white,
                                focusColor: Colors.white,

                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            // Email Field
                            TextField(
                              controller: controller.email.value,
                              cursorColor: Colors.white,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                              enabled: true, // Pre-filled, disable editing
                            ),
                            const SizedBox(
                              height: 10,
                            ), // Increased spacing to match image
                            // Password Field
                            TextField(
                              obscureText: true,
                              cursorColor: Colors.white,
                              controller: controller.password.value,
                              decoration: const InputDecoration(
                                labelText: 'Enter Password',
                                fillColor: Colors.white,
                                focusColor: Colors.white,

                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),

                            const SizedBox(height: 10),

                            TextField(

                              cursorColor: Colors.white,
                              controller: controller.companyName.value,
                              decoration: const InputDecoration(
                                labelText: 'Company Name',
                                fillColor: Colors.white,
                                focusColor: Colors.white,

                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "Select Role",
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  fillColor: Colors.white,
                                  focusColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                dropdownColor: const Color(0xFF2762A1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                iconSize: 24,
                                isExpanded: true,
                                hint: const Text(
                                  "Select Role",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),

                                  // textcolor: Colors.white,
                                ),
                                value:
                                    controller
                                        .selectedRole
                                        .value, // can be null safely
                                items: const [
                                  DropdownMenuItem(
                                    value: "CFO",
                                    child: Text("CFO"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Director",
                                    child: Text("Director"),
                                  ),
                                ],
                                onChanged: (value) {
                                  controller.selectedRole.value =
                                      value; // no need for ?? ''
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Adjusted spacing
                            // Login Button
                            ElevatedButton(
                              onPressed: () {
                                controller.register();
                                // Get.snackbar('Login', 'Login button pressed!');
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF2762A1),
                              ),
                              child: const Text('Register'),
                            ),
                            const SizedBox(
                              height: 10,
                            ), // Bottom padding to match image
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Forgot Password Button
                                // TextButton(
                                //   onPressed: () {
                                //     Get.toNamed(Routes.FORGOTPASSWORD);
                                //   },
                                //   child: const Text(
                                //     'Forgot Password?',
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 16,
                                //     ),
                                //   ),
                                // ),
                                // // Register Button
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.AUTH);
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

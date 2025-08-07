import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui; // Required for ImageFilter
import '../../constant/asset_images.dart';
import 'controllers/auth.controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

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
                      filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85, // Match image width
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2762A1).withOpacity(0.3), //#416ba6// Semi-transparent card background
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
                              'Login to EPFIN',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 30), // Adjust spacing to match image
                            // Email Field
                            TextField(
                              controller: TextEditingController(text: 'tawfiq.it@energypac.com'),
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
                            const SizedBox(height: 20), // Increased spacing to match image
                            // Password Field
                            TextField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Enter Password',
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
                            const SizedBox(height: 30), // Adjusted spacing
                            // Login Button
                            ElevatedButton(
                              onPressed: () {
                                Get.snackbar('Login', 'Login button pressed!');
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF2762A1),
                              ),
                              child: const Text('Login'),
                            ),
                            const SizedBox(height: 10), // Bottom padding to match image
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
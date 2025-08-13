import 'package:epfin/infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/main.dart';
import 'package:epfin/presentation/auth/auth.screen.dart';
import 'package:epfin/presentation/bottomNave/bottom_nave.screen.dart';
import 'package:epfin/presentation/common/bottom_bar.dart';
import 'package:epfin/presentation/common/custom_drawer.dart';
import 'package:epfin/presentation/common/topbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/profile.controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNaveScreen(),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Topbar(title: "Profile"),
          ),

          Positioned(
            top: 175,
            left: 10,
            right: 10,
            bottom: 0,
            child: Obx(() {
              final user = controller.user.value;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture Placeholder
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Name
                    Text(
                      user.name ?? 'User',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Email
                    if (user.email != null)
                      Text(
                        user.email!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Profile Details Card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // _profileRow(
                            //   "User ID",
                            //   user.userId?.toString() ?? "-",
                            // ),
                            // _profileRow("Host Name", user.hostName ?? "-"),
                            _profileRow(
                              "User Type",
                              _getUserType(user.userType),
                            ),
                            _profileRow(
                              "Last Update",
                              user.lastUpdate?.toString() ?? "-",
                            ),
                            // _profileRow(
                            //   "Token",
                            //   user.token != null
                            //       ? "Available"
                            //       : "Not Available",
                            // ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Logout Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: logout,
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void logout() async {
    // await storage.deleteAll();
    prefs.remove('userInfo');
    Get.offAll(const AuthScreen(), binding: AuthControllerBinding());
  }

  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  String _getUserType(int? type) {
    switch (type) {
      case 0:
        return "Admin";
      case 1:
        return "CFO";
      case 2:
        return "Director";
      default:
        return "Unknown";
    }
  }
}

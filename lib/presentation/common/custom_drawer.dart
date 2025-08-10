import 'package:epfin/infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import 'package:epfin/presentation/auth/auth.screen.dart';
import 'package:epfin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _logout() async {
    // await storage.deleteAll();
    prefs.remove('userInfo');
    Get.offAll(const AuthScreen(), binding: AuthControllerBinding());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Get.offAllNamed(Routes.PROFILE);
              // Get.back(); // Close the drawer
              // Add navigation or action for Menu 1 here
            },
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Change Password'),
            onTap: () {
              Get.back();
              Get.offAllNamed(Routes.CHANGE_PASSWORD);
              // Add navigation or action for Menu 2 here
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}

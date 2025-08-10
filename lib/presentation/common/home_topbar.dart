import 'package:epfin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/Get.dart';

import '../../infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import '../auth/auth.screen.dart';

class HomeTopbar extends StatefulWidget {
  HomeTopbar({super.key, required this.title, required this.user});
  String title;
  String user;

  @override
  State<HomeTopbar> createState() => _HomeTopbarState();
}

class _HomeTopbarState extends State<HomeTopbar> {
  void logout() async {
    // await storage.deleteAll();
    prefs.remove('userInfo');
    Get.offAll(const AuthScreen(), binding: AuthControllerBinding());
  }

  void toggleDrawer() {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF004AAD), Color(0xFF0078FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 0,
                bottom: 0,
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "EPFIN",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: logout,
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     IconButton(
              //       icon: const Icon(Icons.logout),
              //       onPressed: logout,
              //       color: Colors.white,
              //     ),
              //     const Center(
              //       child: Text(
              //         "EPFIN",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           decorationColor: Colors.white,
              //           decorationThickness: 2,
              //         ),
              //       ),
              //     ),
              //     // Text(" "),
              //     // IconButton(
              //     //   icon: const Icon(Icons.menu),
              //     //   onPressed: toggleDrawer,
              //     //   color: Colors.white,
              //     // ),
              //   ],
              // ),
            ),
            // SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.user,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  // decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 1,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 1,
                  height: 0, // Adds vertical gap between text and underline
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

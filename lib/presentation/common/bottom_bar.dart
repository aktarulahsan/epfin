import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      print('Loans tapped');
      Get.offAllNamed(Routes.CHANGE_PASSWORD);
      // Navigate if needed
    } else if (index == 1) {
      print('Home tapped');
      Get.offAllNamed(Routes.HOME);
    } else if (index == 2) {
      Get.offAllNamed(Routes.PROFILE);
      print('Profile tapped');
      // Navigate if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.password),
          label: 'Change Password',
        ),
        BottomNavigationBarItem(
          icon: Transform.translate(
            offset: const Offset(0, 0),
            child: const Icon(Icons.home),
          ),
          label: 'Home',
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

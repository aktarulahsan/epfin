import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/bottom_nave.controller.dart';

class BottomNaveScreen extends StatelessWidget {
  BottomNaveScreen({super.key});

  // final BottomNaveController controller = Get.put(BottomNaveController());
  final BottomNaveController controller = Get.put(
    BottomNaveController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: Colors.blue, // Active color
        unselectedItemColor: Colors.grey, // Inactive color
        onTap: controller.onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.password),
            label: 'Change Password',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// class BottomNaveScreen extends GetView<BottomNaveController> {
//   const BottomNaveScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // controller.changeIndex(0);
//     return Obx(() => BottomNavigation(
//       currentIndex: controller.currentIndex.value,
//       onTap: controller.changeIndex,
//     ));
//   }
// }
//
// class BottomNavigation extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const BottomNavigation({
//     required this.currentIndex,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.history),
//           label: 'Loan History',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Loan Entry',
//         ),
//       ],
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//     );
//   }
// }

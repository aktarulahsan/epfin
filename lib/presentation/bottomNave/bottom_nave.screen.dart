// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
// import 'controllers/bottom_nave.controller.dart';
//
// class BottomNaveScreen extends GetView<BottomNaveController> {
//   const BottomNaveScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Stack(
//         children: [
//           Positioned(
//               top: 0,
//               left: 0,
//               child: InkWell(
//             child: Icon(Icons.history_edu),
//           )),
//           Positioned(
//               top: -10,
//               left: 0,
//               child: InkWell(
//                 child: Icon(Icons.history_edu),
//               )),
//           Positioned(
//               top: 0,
//               right: 0,
//               child: InkWell(
//                 onTap: (){
//                   Get.toNamed('/lon-entry');
//                 },
//                 child: Icon(Icons.add_circle_outline),
//               ))
//         ],
//       )
//     );
//   }
// }
//
// // class BottomNaveScreen extends GetView<BottomNaveController> {
// //   const BottomNaveScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // controller.changeIndex(0);
// //     return Obx(() => BottomNavigation(
// //       currentIndex: controller.currentIndex.value,
// //       onTap: controller.changeIndex,
// //     ));
// //   }
// // }
// //
// // class BottomNavigation extends StatelessWidget {
// //   final int currentIndex;
// //   final Function(int) onTap;
// //
// //   const BottomNavigation({
// //     required this.currentIndex,
// //     required this.onTap,
// //     Key? key,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BottomNavigationBar(
// //       currentIndex: currentIndex,
// //       onTap: onTap,
// //       items: const [
// //         BottomNavigationBarItem(
// //           icon: Icon(Icons.history),
// //           label: 'Loan History',
// //         ),
// //         BottomNavigationBarItem(
// //           icon: Icon(Icons.home),
// //           label: 'Loan Entry',
// //         ),
// //       ],
// //       selectedItemColor: Colors.blue,
// //       unselectedItemColor: Colors.grey,
// //     );
// //   }
// // }
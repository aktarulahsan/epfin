import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: TopBar(),
      ),
      // drawer: Obx(() => controller.showDrawer.value
      //     ? Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text(
      //           'Menu',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         title: const Text('Logout'),
      //         onTap: controller.logout,
      //       ),
      //     ],
      //   ),
      // )
      //     : null),
      body: Column(
        children: [
          // Greeting Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.greetingText.value.isNotEmpty)
                    Text(
                      controller.greetingText.value,
                      style: const TextStyle(fontSize: 18),
                    ),
                  if (controller.name.value.isNotEmpty)
                    Text(
                      controller.name.value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Tab Menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => controller.selectTab('Loan Latest Balance'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: controller.selectedTab.value == 'Loan Latest Balance'
                            ? Colors.blue
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Loan Latest Balance',
                        style: TextStyle(
                          color: controller.selectedTab.value == 'Loan Latest Balance'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main Content
          const Expanded(
            child: LoanStatement(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

// Placeholder Widgets
class TopBar extends GetView<HomeController> {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: controller.toggleDrawer,
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: controller.logout,
      ),
    );
  }
}

class LoanStatement extends StatelessWidget {
  const LoanStatement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Loan Statement Content'),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: 'Loans',
        ),
      ],
    );
  }
}

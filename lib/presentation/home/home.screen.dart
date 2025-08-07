import 'package:epfin/infrastructure/dal/model/statement.model.dart';
import 'package:epfin/presentation/bottomNave/bottom_nave.screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../common/bottom_bar.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF004AAD),
                    Color(0xFF0078FF),
                  ],
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
                    // Top Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.logout),
                            onPressed: controller.logout,
                            color: Colors.white,
                          ),
                          const Text(
                            "EPFIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: controller.toggleDrawer,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    // Greeting Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Obx(
                            () => controller.name.value.isNotEmpty
                            ? Text(
                          controller.name.value,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Tab Menu
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  controller.selectTab('Loan Latest Balance'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                decoration: const BoxDecoration(), // No background color
                                child: Text(
                                  'Loan Latest Balance UpTo ${controller.date.value}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: controller.selectedTab.value == 'Loan Latest Balance'
                                        ? Colors.white
                                        : Colors.black,
                                    decoration: controller.selectedTab.value == 'Loan Latest Balance'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    decorationColor: Colors.white, // Optional: underline color
                                    decorationThickness: 2,        // Optional: thickness of underline
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Content Below Header
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 50,
            child: Obx(() {
              if (controller.isLoading.value == 1) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: controller.statementList.length,
                  itemBuilder: (context, index) {
                    final model = controller.statementList[index];
                    return LoanStatement(model: model);
                  },
                );
              }
            }),

          ),
        ],
      ),
      bottomNavigationBar:   BottomBar(),
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
    LoanStatement({super.key, required this.model});
  StatementModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Adjust height as needed to perfectly fit one row
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            // Header
            Container(
              height: 30,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "${model.shortCode} ${model.companyName}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Table with single row
            Expanded(
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                  4: FlexColumnWidth(2),
                  5: FlexColumnWidth(1.5),
                },
                border: TableBorder.all(color: Colors.grey),
                children: [
                  // Header Row
                  const TableRow(
                    decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('Total Loan', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('Over Due', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('SS', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('BL', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(''),
                      ),
                    ],
                  ),

                  // One Data Row
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(formatToIndianCurrency(model.totalLone!), textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(formatToIndianCurrency(model.overDue!), textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(formatToIndianCurrency(model.ss!), textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(formatToIndianCurrency(model.bl!), textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text('${model.status}', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(Icons.edit_calendar, size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    String formatToIndianCurrency(double value) {
      final format = NumberFormat.decimalPattern('en_IN');
      return format.format(value);
    }

}

// class BottomBar extends StatelessWidget {
//   const BottomBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(
//
//           icon: Icon(Icons.account_balance),
//           label: 'Loans',
//         ),
//
//       ],
//     );
//   }
// }



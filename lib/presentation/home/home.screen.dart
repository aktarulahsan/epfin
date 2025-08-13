import 'package:epfin/infrastructure/dal/model/statement.model.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/presentation/bottomNave/bottom_nave.screen.dart';
import 'package:epfin/presentation/common/home_topbar.dart';
import 'package:epfin/presentation/common/loan_statement_edit.dart';
import 'package:epfin/presentation/common/loan_statement_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../common/bottom_bar.dart';
import '../common/custom_drawer.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    //    floatingActionButton:  controller.user.value.userType == 1
    // ? FloatingActionButton(
    //     onPressed: () {
    //   Get.offAllNamed(Routes.LON_ENTRY);
    // },
    // backgroundColor: Colors.blue,
    // shape: const CircleBorder(),
    // child: const Icon(Icons.add_circle, color: Colors.white),
    // )
    //     : null, /
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(() {
        return controller.user.value.userType == 1
            ? FloatingActionButton(
          onPressed: () {
            Get.offAllNamed(Routes.LON_ENTRY);
          },
          child: Icon(Icons.add),
        )
            : SizedBox.shrink(); // Empty widget when condition is false
      }),
      // drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              return HomeTopbar(
                title: 'Loan Latest Balance UpTo ${controller.date.value}',
                user: controller.name.value ?? '',
              );
            }),
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
                    var model = controller.statementList[index];

                    if (controller.user.value.userType == 1) {
                      var date1 = DateFormat(
                        'dd-MMM-yyyy',
                      ).format(model.balanceDate!);
                      var date2 = DateFormat(
                        'dd-MMM-yyyy',
                      ).format(DateTime.now());
                      if (date1 == date2) {
                        return LoanStatementEdit(
                          model: controller.statementList[index],
                          from: 0,
                        );
                      } else {
                        return LoanStatementView(
                          model: controller.statementList[index],
                          from: 0,
                        );
                      }
                    } else {
                      final model = controller.statementList[index];
                      return LoanStatementView(model: model, from: 0);
                    }
                  },
                );
              }
            }),
          ),
        ],
      ),
      // bottomNavigationBar: BottomBar(),
      bottomNavigationBar: BottomNaveScreen(),
    );
  }
}

// Placeholder Widgets
// class TopBar extends GetView<HomeController> {
//   const TopBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text('Home'),
//       centerTitle: true,
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: controller.toggleDrawer,
//         ),
//       ],
//       leading: IconButton(
//         icon: const Icon(Icons.logout),
//         onPressed: controller.logout,
//       ),
//     );
//   }
// }

class LoanStatement extends StatelessWidget {
  LoanStatement({super.key, required this.model});
  StatementModel model;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return SizedBox(
      height: 100, // Adjust height as needed to perfectly fit one row
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            // Header
            Container(
              height: 30,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF5197d5),
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
                    decoration: BoxDecoration(color: Color(0xFF337cf4)),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Total Loan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Over Due',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'SS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'BL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Status',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(2.0), child: Text('')),
                    ],
                  ),

                  // One Data Row
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          formatToIndianCurrency(model.totalLone!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          formatToIndianCurrency(model.overDue!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          formatToIndianCurrency(model.ss!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          formatToIndianCurrency(model.bl!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          '${model.status}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: InkWell(
                          onTap: () {
                            controller
                                .getStatementByShortCode(
                                  model.shortCode,
                                  model.balanceDate.toString(),
                                )
                                .then((value) {
                                  if (value != null) {
                                    Get.toNamed(
                                      Routes.LON_ENTRY,
                                      arguments: value,
                                    );
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "No data found for the selected date.",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                });
                          },
                          child: Icon(Icons.edit, size: 16),
                        ),
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

  String dateFormat(DateTime date) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }
}

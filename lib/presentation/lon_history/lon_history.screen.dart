import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/presentation/bottomNave/bottom_nave.screen.dart';
import 'package:epfin/presentation/common/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:intl/intl.dart';
import '../common/bottom_bar.dart';
import '../common/custom_drawer.dart';
import '../common/loan_statement_view.dart';
import 'controllers/lon_history.controller.dart';

class LonHistoryScreen extends GetView<LonHistoryController> {
  const LonHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LonHistoryController());

    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.offAllNamed(Routes.HOME);
      //   },
      //   backgroundColor: Colors.blue,
      //   shape: const CircleBorder(),
      //   child: const Icon(Icons.home, color: Colors.white),
      // ),
      // bottomNavigationBar: BottomBar(),
      bottomNavigationBar: BottomNaveScreen(),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Topbar(title: "Loan History"),
          ),
          Positioned(
            top: 165,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Center(
                  child: Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.selectedDate.value = controller
                                  .selectedDate
                                  .value
                                  .subtract(const Duration(days: 1));
                              controller.getStatement();
                              // Optionally fetch new data
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat(
                              'dd-MMM-yyyy',
                            ).format(controller.selectedDate.value),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              controller.selectedDate.value = controller
                                  .selectedDate
                                  .value
                                  .add(const Duration(days: 1));
                              controller.getStatement();
                              // Optionally fetch new data
                            },
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),

          Positioned(
            top: 190,
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
                    return LoanStatementView(model: model, from: 1, colorCode: 0xFF2C3E50,index: index,);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

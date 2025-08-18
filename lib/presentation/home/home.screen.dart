import 'package:epfin/infrastructure/dal/model/statement.model.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/presentation/bottomNave/bottom_nave.screen.dart';
import 'package:epfin/presentation/common/home_topbar.dart';
import 'package:epfin/presentation/common/loan_statement_edit.dart';
import 'package:epfin/presentation/common/loan_statement_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: Obx(() {
      //   return controller.user.value.userType == 1
      //       ? FloatingActionButton(
      //         onPressed: () {
      //           Get.offAllNamed(Routes.LON_ENTRY);
      //         },
      //         child: Icon(
      //           Icons.add_circle_outline_sharp,
      //           size: 40,
      //           color: Colors.white,
      //         ),
      //       )
      //       : SizedBox.shrink(); // Empty widget when condition is false
      // }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Obx(() {
        return controller.user.value.userType == 1
            ? FloatingActionButton(
              onPressed: () {
                Get.offAllNamed(Routes.LON_ENTRY);
              },
              backgroundColor: Color(0xFF004AAD), // Blue background color
              shape:
                  CircleBorder(), // Ensures circular shape (optional, as FAB is circular by default)
              child: Icon(
                Icons.add_circle_outline,
                color: Colors.white, // White icon color
                size: 34, // Adjust size if needed for better appearance
              ),
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
            top: 190,
            left: 0,
            right: 0,
            bottom: 50,
            child: Obx(() {
              if (controller.isLoading.value == 1) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.isLoading.value == 0 &&
                  controller.statementList.isEmpty) {
                return Text(
                  " Welcome to Lon entry",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.statementList.length,
                  dragStartBehavior: DragStartBehavior.start,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  shrinkWrap: true,
                  // physics: ScrollPhysics(),
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

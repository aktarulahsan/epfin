import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/presentation/bottomNave/bottom_nave.screen.dart';
import 'package:epfin/presentation/common/home_topbar.dart';
import 'package:epfin/presentation/common/loan_statement_edit.dart';
import 'package:epfin/presentation/common/loan_statement_view.dart';
import 'package:epfin/presentation/common/nodatacard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upgrader/upgrader.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final upgraded = Upgrader(
      durationUntilAlertAgain: Duration.zero, // check every app open
      storeController: UpgraderStoreController(
        onAndroid: () => UpgraderPlayStore(), // Play Store check
        oniOS: () => UpgraderAppStore(), // App Store check
      ),
    );

    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      upgrader: upgraded,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Obx(() {
          return controller.user.value.userType == 1
              ? FloatingActionButton(
                onPressed: () {
                  Get.offAllNamed(Routes.LON_ENTRY);
                },
                backgroundColor: Color(0xFF0078FF), // Blue background color
                shape:
                    CircleBorder(), // Ensures circular shape (optional, as FAB is circular by default)
                child: Icon(
                  Icons.add_circle_outline,
                  color: Colors.white, // White icon color
                  size: 34, // Adjust size if needed for better appearance
                ),
              )
              : controller.user.value.role == 'Admin' ||
                  controller.user.value.role == 'Editor'
              ? FloatingActionButton(
                onPressed: () {
                  Get.offAllNamed(Routes.LON_ENTRY);
                },
                backgroundColor: Color(0xFF0078FF), // Blue background color
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
              bottom: 0,
              child: Obx(() {
                if (controller.isLoading.value == 1) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.isLoading.value == 0 &&
                    controller.statementList.isEmpty) {
                  return Center(
                    child: NoDataCard(),
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
                      // final colorCode = controller.getColorForIndex(index);
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
                            colorCode: controller.getColorForIndex(index),
                          );
                        } else {
                          return LoanStatementView(
                            model: controller.statementList[index],
                            from: 0,
                            colorCode: controller.getColorForIndex(index),
                            index: index,
                          );
                        }
                      } else {
                        final model = controller.statementList[index];
                        return LoanStatementView(model: model, from: 0,colorCode: controller.getColorForIndex(index),index: index,);
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
      ),
    );
  }
}

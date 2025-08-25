import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/dal/model/statement.model.dart';

class LoanStatementEdit extends StatelessWidget {
  const LoanStatementEdit({super.key, required this.model, required this.from, required this.colorCode});
  final StatementModel model;
  final dynamic from;
  // final String colorCode;// = "#0078FF";
  final int? colorCode;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();

    // Card color based on status
    Color statusColor =
        model.status == "Classical"
            ? Colors.green.shade100
            : Colors.red.shade100;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      // color: Colors.white,
      color: Color(0xFFf0f2f5), // Card background set to white for contrast
      child: Column(
        children: [
          // Header: Blue with companyName
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF3399ff), // Blue header
              // color: Color(colorCode!),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              "${model.companyName}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text for contrast
              ),
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10,
            ),
            child:_buildLoanTable({
          "Total Loan":
          formatToIndianCurrency(model.totalLone!),
          "Over Due": formatToIndianCurrency(model.overDue!),
          "SS":formatToIndianCurrency(model.ss!),
          "BL": formatToIndianCurrency(model.bl!),
          })


            // Column(
            //   children: [
            //     _buildInfoTile(
            //       "Total Loan",
            //       formatToIndianCurrency(model.totalLone!),
            //     ),
            //     _buildInfoTile(
            //       "Over Due",
            //       formatToIndianCurrency(model.overDue!),
            //     ),
            //
            //     _buildInfoTile("SS", formatToIndianCurrency(model.ss!)),
            //     _buildInfoTile("BL", formatToIndianCurrency(model.bl!)),
            //
            //   ],
            // ),
          ),
          // Footer: Blue with status and edit icon
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF3399ff), // Blue footer
              // color: Color(colorCode!),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        model.status == "Classical" ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    model.status!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(1.0),
                  width: context.isPhone ? 25 : 30,
                  height: context.isPhone ? 25 : 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color:
                        Colors
                            .white, // White background for edit icon to contrast with footer
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: InkWell(
                    onTap: () {
                      controller
                          .getStatementByShortCode(
                            model.shortCode,
                            model.balanceDate.toString(),
                          )
                          .then((value) {
                            if (value != null) {
                              Get.toNamed(Routes.LON_ENTRY, arguments: value);
                            } else {
                              Get.snackbar(
                                "Error",
                                "No data found for the selected date.",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          });
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                      color: Color(0xFF004AAD), // Blue icon to match theme
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Table _buildLoanTable(Map<String, String> data) {
    return Table(
      border: TableBorder.all(color: Colors.black26), // shared borders
      columnWidths: const {
        0: FlexColumnWidth(5), // Label column
        1: FlexColumnWidth(1), // Separator
        2: FlexColumnWidth(7), // Value column
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle, // Center content vertically
      children: data.entries.map((entry) {
        return TableRow(
          decoration: const BoxDecoration(color: Colors.white), // Row background
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(2),
                child: Text(
                  "${entry.key} (BDT)",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 0),
                child: const Text(":"),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(2),
                child: Text(
                  entry.value,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
  // Widget _buildInfoTile(String label, String value) {
  //   return Container(
  //     color: Colors.white, // Row background
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Label Cell
  //         Expanded(
  //           flex: 5,
  //           child: Container(
  //             padding: const EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //               color: Colors.white, // Cell background
  //               border: Border.all(color: Colors.black26, width: 1), // Cell border
  //             ),
  //             child: Text(
  //               "$label (BDT)",
  //               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ),
  //         // Separator Cell
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.black26, width: 1),
  //             ),
  //             child: const Text(":"),
  //           ),
  //         ),
  //         // Value Cell
  //         Expanded(
  //           flex: 7,
  //           child: Container(
  //             padding: const EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //               color: Colors.white, // Cell background
  //               border: Border.all(color: Colors.black26, width: 1),
  //             ),
  //             child: Text(
  //               "$value",
  //               style: const TextStyle(fontSize: 15),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  String formatToIndianCurrency(double value) {
    final format = NumberFormat.decimalPattern('en_US');
    return format.format(value);
  }
}

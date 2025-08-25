import 'dart:math';

import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/dal/model/statement.model.dart';


class LoanStatementView extends StatelessWidget {
  const LoanStatementView({super.key, required this.model, required this.from, required this.colorCode, required this.index});
  final StatementModel model;
  final dynamic from;
  final int? colorCode;
  final int? index;




  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      color: Color(0xFFf0f2f5), // Card background set to white for contrast
      child: Column(
        children: [
          // Header: Blue with companyName
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: model.companyName =='Grand Total'?  Color(0xFF8599ad): Color(0xFF3399ff), // Blue header
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

          //     Table(
          //   border: TableBorder.all(color: Colors.black26), // Optional outer border
          //   columnWidths: const {
          //     0: FlexColumnWidth(5),
          //     1: FlexColumnWidth(1),
          //     2: FlexColumnWidth(7),
          //   },
          //   children: [
          //     _buildInfoTableRow( "Total Loan",
          //       formatToIndianCurrency(model.totalLone!)),
          //     _buildInfoTableRow("Over Due",
          //       formatToIndianCurrency(model.overDue!)),
          //     _buildInfoTableRow("SS", formatToIndianCurrency(model.ss!)),
          //     _buildInfoTableRow("BL", formatToIndianCurrency(model.bl!)),
          //   ],
          // )


          ),
          // Body
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 10,
          //     right: 10,
          //     top: 10,
          //     bottom: 10,
          //   ),
          //   child: Column(
          //     children: [
          //       _buildInfoTile(
          //         "Total Loan",
          //         formatToIndianCurrency(model.totalLone!),
          //       ),
          //       _buildInfoTile(
          //         "Over Due",
          //         formatToIndianCurrency(model.overDue!),
          //       ),
          //
          //       _buildInfoTile("SS", formatToIndianCurrency(model.ss!)),
          //       _buildInfoTile("BL", formatToIndianCurrency(model.bl!)),
          //     ],
          //   ),
          // ),
          // Footer: Blue with status and edit icon
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: model.companyName =='Grand Total'?  Color(0xFF8599ad): Color(0xFF3399ff), // Blue header// Blue footer
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
                        model.status == "Classical" ? Colors.green : model.status == "" ? Color(0xFF8599ad) : Colors.red,
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

              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildInfoTile(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 1, right: 1, bottom: 1),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(
  //           flex: 5,
  //           child: Container(
  //             decoration: BoxDecoration(color: Colors.black12),
  //             child: Text(
  //               "$label (BDT)",
  //               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  //             ),
  //           )
  //         ),
  //         // SizedBox(width: 5, child: Text(":   ")),
  //         Expanded(flex: 1, child: Text(":")), // Spacer for alignment
  //         Expanded(
  //           flex: 7,
  //           child: Text("$value", style: const TextStyle(fontSize: 15)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

  TableRow _buildInfoTableRow(String label, String value) {
    return TableRow(
      decoration: const BoxDecoration(
        color: Colors.white, // Row background
      ),
      children: [
        // Label Cell
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            color: Colors.white,
          ),
          child: Text(
            "$label (BDT)",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        // Separator Cell
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            color: Colors.white,
          ),
          child: const Text(":"),
        ),
        // Value Cell
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            color: Colors.white,
          ),
          child: Text(
            "$value",
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

  String formatToIndianCurrency(double value) {
    final format = NumberFormat.decimalPattern('en_US');
    return format.format(value);
  }
}

import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/dal/model/statement.model.dart';

// class LoanStatementEdit extends StatelessWidget {
//   LoanStatementEdit({super.key, required this.model, required this.from});
//   StatementModel model;
//   var from;

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<HomeController>();

//     return SizedBox(
//       height: 100, // Adjust height as needed to perfectly fit one row
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         margin: const EdgeInsets.all(5),
//         child: Column(
//           children: [
//             // Header
//             Container(
//               height: 30,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF5197d5),
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//               ),
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               child: Row(
//                 children: [
//                   Text(
//                     "${model.shortCode} ${model.companyName}",
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                   const Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(1.0),
//                     child: InkWell(
//                       onTap: () {
//                         controller
//                             .getStatementByShortCode(
//                               model.shortCode,
//                               model.balanceDate.toString(),
//                             )
//                             .then((value) {
//                               if (value != null) {
//                                 Get.toNamed(Routes.LON_ENTRY, arguments: value);
//                               } else {
//                                 Get.snackbar(
//                                   "Error",
//                                   "No data found for the selected date.",
//                                   snackPosition: SnackPosition.BOTTOM,
//                                 );
//                               }
//                             });
//                       },
//                       child: Icon(Icons.edit, size: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Table with single row
//             Expanded(
//               child: Table(
//                 columnWidths: const {
//                   0: FlexColumnWidth(2),
//                   1: FlexColumnWidth(2),
//                   2: FlexColumnWidth(2),
//                   3: FlexColumnWidth(2),
//                   4: FlexColumnWidth(2),
//                   // 5: FlexColumnWidth(1.5),
//                 },
//                 border: TableBorder.all(color: Colors.grey),
//                 children: [
//                   // Header Row
//                   TableRow(
//                     decoration: const BoxDecoration(color: Color(0xFF337cf4)),
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           'Total Loan',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           'Over Due',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           'SS',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           'BL',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: Text(
//                           'Status',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       // const Padding(
//                       //   padding: EdgeInsets.all(2.0),
//                       //   child: Text(''),
//                       // ),
//                     ],
//                   ),

//                   // One Data Row
//                   TableRow(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: Text(
//                           formatToIndianCurrency(model.totalLone!),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 11),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: Text(
//                           formatToIndianCurrency(model.overDue!),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 11),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: Text(
//                           formatToIndianCurrency(model.ss!),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 11),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: Text(
//                           formatToIndianCurrency(model.bl!),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 11),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: Text(
//                           '${model.status}',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 11),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.all(1.0),
//                       //   child: InkWell(
//                       //     onTap: () {
//                       //       controller
//                       //           .getStatementByShortCode(
//                       //             model.shortCode,
//                       //             model.balanceDate.toString(),
//                       //           )
//                       //           .then((value) {
//                       //             if (value != null) {
//                       //               Get.toNamed(
//                       //                 Routes.LON_ENTRY,
//                       //                 arguments: value,
//                       //               );
//                       //             } else {
//                       //               Get.snackbar(
//                       //                 "Error",
//                       //                 "No data found for the selected date.",
//                       //                 snackPosition: SnackPosition.BOTTOM,
//                       //               );
//                       //             }
//                       //           });
//                       //     },
//                       //     child: Icon(Icons.edit, size: 16),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String formatToIndianCurrency(double value) {
//     final format = NumberFormat.decimalPattern('en_IN');
//     return format.format(value);
//   }
// }

class LoanStatementEdit extends StatelessWidget {
  LoanStatementEdit({super.key, required this.model, required this.from});
  final StatementModel model;
  final dynamic from;

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
      color: Colors.white, // Card background set to white for contrast
      child: Column(
        children: [
          // Header: Blue with companyName
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF0078FF), // Blue header
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
            child: Column(
              children: [
                _buildInfoTile(
                  "Total Loan",
                  formatToIndianCurrency(model.totalLone!),
                ),
                _buildInfoTile(
                  "Over Due",
                  formatToIndianCurrency(model.overDue!),
                ),

                _buildInfoTile("SS", formatToIndianCurrency(model.ss!)),
                _buildInfoTile("BL", formatToIndianCurrency(model.bl!)),

                // Two-column layout for info tiles
                // Row(
                //   children: [
                //     Expanded(
                //       child: _buildInfoTile(
                //         "Total Loan",
                //         formatToIndianCurrency(model.totalLone!),
                //       ),
                //     ),
                //     const SizedBox(width: 10), // Spacing between columns
                //     Expanded(
                //       child: _buildInfoTile(
                //         "Over Due",
                //         formatToIndianCurrency(model.overDue!),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 6),
                // Row(
                //   children: [
                //     Expanded(
                //       child: _buildInfoTile(
                //         "SS",
                //         formatToIndianCurrency(model.ss!),
                //       ),
                //     ),
                //     const SizedBox(width: 10), // Spacing between columns
                //     Expanded(
                //       child: _buildInfoTile(
                //         "BL",
                //         formatToIndianCurrency(model.bl!),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          // Footer: Blue with status and edit icon
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF0078FF), // Blue footer
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

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 1, bottom: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              "$label (BDT)",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          // SizedBox(width: 5, child: Text(":   ")),
          Expanded(flex: 1, child: Text(":")), // Spacer for alignment
          Expanded(
            flex: 7,
            child: Text("$value", style: const TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }

  String formatToIndianCurrency(double value) {
    final format = NumberFormat.decimalPattern('en_IN');
    return format.format(value);
  }
}

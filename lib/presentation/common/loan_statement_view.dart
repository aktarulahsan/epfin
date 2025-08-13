import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/dal/model/statement.model.dart';

class LoanStatementView extends StatelessWidget {
  LoanStatementView({super.key, required this.model, required this.from});
  StatementModel model;
  var from;

  @override
  Widget build(BuildContext context) {
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
                  fontSize: 12,
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
                  // 5: FlexColumnWidth(1.5),
                },
                border: TableBorder.all(color: Colors.grey),
                children: [
                  // Header Row
                  TableRow(
                    decoration: const BoxDecoration(color: Color(0xFF337cf4)),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Total Loan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Over Due',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'SS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'BL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          'Status',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // from == 0
                      //     ? const Padding(
                      //       padding: EdgeInsets.all(2.0),
                      //       child: Text(''),
                      //     )
                      //     : const SizedBox(),
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
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          formatToIndianCurrency(model.overDue!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          formatToIndianCurrency(model.ss!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          formatToIndianCurrency(model.bl!),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          '${model.status}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      // from == 0
                      //     ? Padding(
                      //       padding: const EdgeInsets.all(1.0),
                      //       child: InkWell(
                      //         onTap: () {
                      //           Get.toNamed(
                      //             Routes
                      //                 .LON_ENTRY, // Assuming Routes.LOAN_ENTRY points to LonEntryScreen
                      //             arguments:
                      //                 model, // Pass the StatementModel object as an argument
                      //           );
                      //         },
                      //         child: Icon(Icons.edit, size: 16),
                      //       ),
                      //     )
                      //     : SizedBox(),
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

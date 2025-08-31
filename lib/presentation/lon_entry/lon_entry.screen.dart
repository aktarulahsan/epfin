import 'package:epfin/presentation/common/topbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../common/bottom_bar.dart';
import '../common/custom_drawer.dart';
import 'controllers/lon_entry.controller.dart';

class LonEntryScreen extends GetView<LonEntryController> {
  const LonEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LonEntryController());

    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.offAllNamed(Routes.HOME);
      //   },
      //   backgroundColor: Colors.blue,
      //   shape: const CircleBorder(),
      //   child: const Icon(Icons.home),
      // ),
      bottomNavigationBar: BottomBar(),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Topbar(title: "Loan Entry"),
          ),
          Obx(
            () =>
                controller.responseSMS.value.isEmpty
                    ? Positioned(
                      top: 161,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            shortCordList(controller),
                            const SizedBox(height: 10),
                            balanceDate(controller),
                            const SizedBox(height: 10),
                            totalLoan(
                              'Total Loan',
                              controller.totalLoan.value,
                              'totalLoan',
                            ),
                            const SizedBox(height: 10),
                            totalLoan(
                              'Over Due',
                              controller.overDue.value,
                              'overDue',
                            ),
                            const SizedBox(height: 10),
                            totalLoan('SS', controller.ss.value, 'ss'),
                            const SizedBox(height: 10),
                            totalLoan('BL', controller.bl.value, 'bl'),
                            const SizedBox(height: 10),
                            // totalLoan(
                            //   'Status',
                            //   controller.status.value,
                            //   'status',
                            // ),
                            statusList(controller),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: TextButton(
                                onPressed: () {
                                  if (validateFields(controller)) {
                                    if (controller.user.value.userTypeName ==
                                        "web") {
                                      controller.submitLoanData();
                                    } else {
                                      controller.submitData();
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : Positioned(
                      top: 250,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: const Color(0xFFE6F3E6),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // CircleAvatar(
                                  //   radius: 30,
                                  //   backgroundColor: controller.responseType.value == 0
                                  //         ? const Colors.green
                                  //         : controller.responseType.value == 1
                                  //         ? const Colors.orange
                                  //         : const Colors.red,

                                  //   child: Icon(
                                  //     controller.responseType.value == 0
                                  //         ? Icons.check
                                  //         : controller.responseType.value == 1
                                  //         ? Icons.warning
                                  //         : Icons.error,
                                  //     size: 40,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: _getBackgroundColor(
                                      controller.responseType.value,
                                    ),
                                    child: Icon(
                                      _getIcon(controller.responseType.value),
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),

                                  const SizedBox(height: 16),
                                  Text(
                                    controller.responseMessage.value,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  // const SizedBox(height: 8),
                                  // const Text(
                                  //   'Your information has been Save.',
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     color: Colors.black54,
                                  //   ),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(int value) {
    switch (value) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  IconData _getIcon(int value) {
    switch (value) {
      case 0:
        return Icons.check;
      case 1:
        return Icons.warning;
      default:
        return Icons.error;
    }
  }

  /// Validate required fields
  bool validateFields(LonEntryController controller) {
    controller.invalidFields.clear();

    if (controller.selectedShortCode.value.isEmpty) {
      controller.invalidFields.add('shortCode');
    }
    if (controller.balanceDateController.value.text.trim().isEmpty) {
      controller.invalidFields.add('balanceDate');
    }
    if (controller.totalLoan.value.text.trim().isEmpty) {
      controller.invalidFields.add('totalLoan');
    }
    if (controller.overDue.value.text.trim().isEmpty) {
      controller.invalidFields.add('overDue');
    }
    if (controller.ss.value.text.trim().isEmpty) {
      controller.invalidFields.add('ss');
    }
    if (controller.bl.value.text.trim().isEmpty) {
      controller.invalidFields.add('bl');
    }
    if (controller.selectStatus.value.isEmpty) {
      controller.invalidFields.add('status');
    }

    controller.invalidFields.refresh();

    return controller.invalidFields.isEmpty;
  }

  // Widget shortcode(LonEntryController controller) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       const Expanded(
  //         flex: 3,
  //         child: Text(
  //           'Short Code *',
  //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Expanded(
  //         flex: 7,
  //         child: Obx(() {
  //           return Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 5),
  //             decoration: BoxDecoration(
  //               color: Colors.grey[200],
  //               border: Border.all(
  //                 color:
  //                     controller.invalidFields.contains('shortCode')
  //                         ? Colors.red
  //                         : Colors.transparent,
  //               ),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: DropdownButton<String>(
  //               value:
  //                   controller.selectedShortCode.value.isEmpty
  //                       ? null
  //                       : controller.selectedShortCode.value,
  //               hint: const Text('Select Short Code'),
  //               isExpanded: true,
  //               underline: const SizedBox(),
  //               items:
  //                   controller.companyList
  //                       .map(
  //                         (company) => DropdownMenuItem<String>(
  //                           value: company.shortCode,
  //                           child: Text(company.shortCode ?? ""),
  //                         ),
  //                       )
  //                       .toList(),
  //               onChanged: (value) {
  //                 controller.selectShortCode.value = controller.companyList
  //                     .firstWhere((p) => p.shortCode == value);
  //                 controller.selectedShortCode.value = value ?? '';
  //               },
  //             ),
  //           );
  //         }),
  //       ),
  //     ],
  //   );
  // }

  /*Widget shortcode(LonEntryController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 3,
          child: Text(
            'Short Code *',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
          child: Obx(() {
            final companies =
                controller.companyList
                    .where(
                      (c) => c.shortCode != null && c.shortCode!.isNotEmpty,
                    )
                    .toList();

            final currentValue =
                companies.any(
                      (c) => c.shortCode == controller.selectedShortCode.value,
                    )
                    ? controller.selectedShortCode.value
                    : null;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color:
                      controller.invalidFields.contains('shortCode')
                          ? Colors.red
                          : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: controller.selectedShortCode.value,// currentValue,
                hint: const Text('Select Short Code'),
                isExpanded: true,
                underline: const SizedBox(),
                items:
                    companies
                        .map(
                          (company) => DropdownMenuItem<String>(
                            value: company.shortCode!,
                            child: Text(company.shortCode!),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectShortCode.value = companies.firstWhere(
                      (p) => p.shortCode == value,
                    );
                    controller.selectedShortCode.value = value;
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }*/

  Widget shortCordList(LonEntryController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 3,
          child: Text(
            'Short Code *',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
          child: Obx(() {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color:
                      controller.invalidFields.contains('shortCode')
                          ? Colors.red
                          : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value:
                    controller.selectedShortCode.value.isEmpty
                        ? null
                        : controller.selectedShortCode.value,
                hint: const Text('Select shortCode'),
                isExpanded: true,
                underline: const SizedBox(),
                items:
                    controller.selectedShortCodeList
                        .map(
                          (status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          ),
                        )
                        .toList(),

                onChanged: (value) {
                  controller.selectedShortCode.value = value ?? '';
                  // controller.status.value.text = value ?? '';
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget statusList(LonEntryController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 3,
          child: Text(
            'Status *',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
          child: Obx(() {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color:
                      controller.invalidFields.contains('status')
                          ? Colors.red
                          : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value:
                    controller.selectStatus.value.isEmpty
                        ? null
                        : controller.selectStatus.value,
                hint: const Text('Select Status'),
                isExpanded: true,
                underline: const SizedBox(),
                items:
                    controller.statusList
                        .map(
                          (status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          ),
                        )
                        .toList(),

                onChanged: (value) {
                  controller.selectStatus.value = value ?? '';
                  controller.status.value.text = value ?? '';
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget balanceDate(LonEntryController controller) {
    // final controller = Get.find<LonEntryController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          flex: 3,
          child: Text(
            'Balance Date *',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
          child: Obx(() {
            return Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  color:
                      controller.invalidFields.contains('balanceDate')
                          ? Colors.red
                          : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                // onTap: () => controller.pickDate(Get.context!),
                onTap:
                    controller.id.value == 0 ||
                            controller.id.value.toString().isEmpty
                        ? () => controller.pickDate(Get.context!)
                        : null, // Disable tap if id

                child: AbsorbPointer(
                  child: TextField(
                    controller: controller.balanceDateController.value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.grey[600],
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget totalLoan(String title, TextEditingController cont, String fieldKey) {
    final formatter = NumberFormat.decimalPattern('en_US');
    final controller = Get.find<LonEntryController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(
              text: title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Obx(() {
            bool isInvalid = controller.invalidFields.contains(fieldKey);
            return TextField(
              controller: cont,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isInvalid ? Colors.red : Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isInvalid ? Colors.red : Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isInvalid ? Colors.red : Colors.blue,
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty &&
                    double.tryParse(value.replaceAll(',', '')) != null) {
                  final number = double.parse(value.replaceAll(',', ''));
                  cont.value = TextEditingValue(
                    text: formatter.format(number),
                    selection: TextSelection.collapsed(
                      offset: formatter.format(number).length,
                    ),
                  );
                }
              },
            );
          }),
        ),
      ],
    );
  }
}

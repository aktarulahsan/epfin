import 'package:epfin/infrastructure/dal/model/company_model.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
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
    Get.put(LonEntryController());

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAllNamed(Routes.HOME);
        },
        backgroundColor: Colors.blue, // Optional: set background color
        shape: const CircleBorder(), // Ensures it's circular (optional)
        child: const Icon(Icons.home),
      ),

      bottomNavigationBar: BottomBar(),
      drawer:  const CustomDrawer(),
      body: Stack(

        children: [
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 160,
          //     decoration: const BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [Color(0xFF004AAD), Color(0xFF0078FF)],
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //       ),
          //       borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(15),
          //         bottomRight: Radius.circular(15),
          //       ),
          //     ),
          //     child: SafeArea(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           // Top Bar
          //           Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 5.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 IconButton(
          //                   icon: const Icon(Icons.logout),
          //                   onPressed: controller.logout,
          //                   color: Colors.white,
          //                 ),
          //                 const Text(
          //                   "EPFIN",
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold,
          //                     decorationColor:
          //                         Colors.white, // Optional: underline color
          //                     decorationThickness: 2,
          //                   ),
          //                 ),
          //                 IconButton(
          //                   icon: const Icon(Icons.menu),
          //                   onPressed: controller.toggleDrawer,
          //                   color: Colors.white,
          //                 ),
          //               ],
          //             ),
          //           ),
          //
          //           // Greeting Section
          //           const SizedBox(height: 10),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //             child: Text(
          //               'Loan Entry',
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.white,
          //                 decoration: TextDecoration.underline,
          //                 decorationColor:
          //                     Colors.white, // Optional: underline color
          //                 decorationThickness: 1,
          //               ),
          //             ),
          //           ),
          //
          //           // Tab Menu
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child:  Topbar(title: "Loan Entry",),

          ),
         Obx(()=> controller.responseSMS.value.isEmpty?
             Positioned(
               top: 161,
               left: 0,
               right: 0,
               bottom: 0,

               child: SingleChildScrollView(
                 padding: const EdgeInsets.all(16),
                 child: Column(
                   children: [
                     shortcode(),
                     SizedBox(height: 10),
                     balanceDate(),

                     SizedBox(height: 10),
                     totalLoan('Total Loan *', controller.totalLoan.value),

                     SizedBox(height: 10),
                     totalLoan('Over Due *', controller.overDue.value),

                     SizedBox(height: 10),
                     totalLoan('SS *', controller.ss.value),

                     SizedBox(height: 10),
                     totalLoan('BL *', controller.bl.value),

                     SizedBox(height: 10),
                     totalLoan('Status *', controller.status.value),

                     SizedBox(height: 30),
                     SizedBox(
                       width: double.infinity,
                       child: TextButton(
                         onPressed: () {
                           // Your submit logic here
                           controller.submitData();
                         },
                         style: TextButton.styleFrom(
                           backgroundColor: Colors.blue,
                           foregroundColor: Colors.white,
                           padding: const EdgeInsets.symmetric(vertical: 16),
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
           // bottom: 0,
           child: Center(
             child: SizedBox(
               width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
               child: Card(
                 elevation: 4,
                 margin: EdgeInsets.all(5),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12),
                 ),
                 color: Color(0xFFE6F3E6), // Light green background
                 child: Padding(
                   padding: EdgeInsets.all(16),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       CircleAvatar(
                         radius: 30,
                         backgroundColor: Color(0xFF4CAF50), // Green checkmark background
                         child: Icon(
                           controller.responseType.value == 0
                               ? Icons.check
                               : controller.responseType.value == 1
                               ? Icons.warning
                               : Icons.error,
                           size: 40,
                           color: Colors.white,
                         ),
                       ),
                       SizedBox(height: 16),
                       Text(
                         controller.responseType.value == 0
                             ? 'Data Update Successfully'
                             : controller.responseType.value == 1
                             ? 'Data Update Failed'
                             : 'Something Rong',
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: Colors.black87,
                         ),
                       ),
                       SizedBox(height: 8),
                       Text(
                         'Your information has been updated.',
                         style: TextStyle(
                           fontSize: 16,
                           color: Colors.black54,
                         ),
                         textAlign: TextAlign.center,
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         ),

         )
        ],
      ),
    );
  }

  Widget shortcode() {
    final controller = Get.find<LonEntryController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Short Code *',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value:
                        controller.selectedShortCode.value.isEmpty
                            ? null
                            : controller.selectedShortCode.value,
                    hint: Text('Select Short Code'),
                    isExpanded: true,
                    underline: SizedBox(),
                    items:
                        controller.companyList
                            .map(
                              (company) => DropdownMenuItem<String>(
                                value: company.shortCode,
                                child: Text(company.shortCode!),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      controller.selectShortCode.value = controller.companyList
                          .firstWhere((p) => p.shortCode == value);
                      controller.selectedShortCode.value = value ?? '';
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  /*Widget balanceDate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Balance Date *',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  // obscureText: true,
                  controller: TextEditingController(
                    text: dateFormat(controller.balanceDate.value),
                  ),
                  // decoration: const InputDecoration(
                  //   labelText: '',
                  //   labelStyle: TextStyle(color: Colors.white),
                  // ),
                  enabled: false,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        // Add more fields in the row if needed, e.g., another text field
      ],
    );
  }*/
  Widget balanceDate() {
    final controller = Get.find<LonEntryController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Balance Date *',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () => controller.pickDate(Get.context!),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: controller.balanceDateController.value,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget totalLoan(String title, TextEditingController cont) {
    final formatter = NumberFormat.decimalPattern('en_IN');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 7,
          child: TextField(
            controller: cont,
            keyboardType:
                TextInputType.text, // Keep text so user can type anything
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
            onChanged: (value) {
              // Check if value is numeric
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
          ),
        ),
      ],
    );
  }

  String dateFormat(DateTime date) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }
}

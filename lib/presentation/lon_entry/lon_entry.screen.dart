import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

 
import '../common/bottom_bar.dart';
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

        bottomNavigationBar:   BottomBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 160,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF004AAD),
                    Color(0xFF0078FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.logout),
                            onPressed: controller.logout,
                            color: Colors.white,
                          ),
                          const Text(
                            "EPFIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.white, // Optional: underline color
                              decorationThickness: 2,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: controller.toggleDrawer,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    // Greeting Section


                    const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                      'Loan Entry',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white, // Optional: underline color
                        decorationThickness: 1,

                      ),
                    ),)
                    // Tab Menu

                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 161,
            left: 0,
            right: 0,
            bottom: 0,

            child:SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                shortcode(),
                SizedBox(height: 10,),
                balanceDate(),
                SizedBox(height: 10,),
                totalLoan('Short Code *',controller.shortCode.value),
                SizedBox(height: 10,),
                totalLoan('Over Due *',controller.totalLoan.value),

                SizedBox(height: 10,),
                totalLoan('SS *',controller.ss.value),

                SizedBox(height: 10,),
                totalLoan('BL *',controller.bl.value),

                SizedBox(height: 10,),
                totalLoan('Status *',controller.status.value),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     // style: ButtonStyle(overlayColor: Colors.blue),
                //
                //     onPressed: () {
                //       // Handle submit logic here
                //       // print("Submitted: ${_controller.text}");
                //     },
                //     child: const Text("Submit"),
                //   ),
                // ),
                SizedBox(height: 30,),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // Your submit logic here
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
                )
              ],
            )),
          ),
        ],
      )



    );
  }

  Widget shortcode(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Expanded(
      flex: 3,
      child: Text(
          'Short Code *',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  hint: Text('EEL'),
                  isExpanded: true,
                  underline: SizedBox(),
                  items: <String>['EEL', 'Option 2', 'Option 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
        ),
        // Add more fields in the row if needed, e.g., another text field
      ],
    );
  }

  Widget balanceDate(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
          'Balance Date *',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  // obscureText: true,
                  controller:TextEditingController(text: dateFormat(controller.balanceDate.value)) ,
                  decoration: const InputDecoration(
                    labelText: '',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
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
  }

  Widget totalLoan(var title, TextEditingController cont){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
          '$title',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),),
        Expanded(
            flex: 7,
          child:
          TextField(
            controller: cont,
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
          )

        ),
        // Add more fields in the row if needed, e.g., another text field
      ],
    );
  }


 String dateFormat(DateTime date){

    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }

}
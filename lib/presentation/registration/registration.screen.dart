// import 'dart:ui' as ui;

// import 'package:epfin/constant/asset_images.dart';
// import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/registration.controller.dart';

// class RegistrationScreen extends GetView<RegistrationController> {
//   const RegistrationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background Image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(AppAssetsImages.logo6), // Background image
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Content
//           Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Login Form Card with Blur Effect
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: BackdropFilter(
//                       filter: ui.ImageFilter.blur(
//                         sigmaX: 10,
//                         sigmaY: 10,
//                       ), // Blur effect
//                       child: Container(
//                         width:
//                             MediaQuery.of(context).size.width *
//                             0.85, // Match image width
//                         padding: const EdgeInsets.all(20.0),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF2762A1).withOpacity(
//                             0.4,
//                           ), // FF2762A1//#416ba6// Semi-transparent card background
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26.withOpacity(0.3),
//                               blurRadius: 15,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Image.asset(
//                               AppAssetsImages.logo, // Logo image
//                               height: 40,
//                               // color: Colors.white,
//                               fit: BoxFit.fill, // White tint to match image
//                             ),
//                             const SizedBox(height: 10),
//                             const Text(
//                               'Registration to EPFIN',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             ), // Adjust spacing to match image
//                             TextField(
//                               // obscureText: true,
//                               cursorColor: Colors.white,
//                               controller: controller.name.value,
//                               decoration: const InputDecoration(
//                                 labelText: 'Enter Name',
//                                 fillColor: Colors.white,
//                                 focusColor: Colors.white,

//                                 labelStyle: TextStyle(color: Colors.white),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                               ),
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                             const SizedBox(height: 10),
//                             // Email Field
//                             TextField(
//                               controller: controller.email.value,
//                               cursorColor: Colors.white,
//                               decoration: const InputDecoration(
//                                 labelText: 'Email',
//                                 fillColor: Colors.white,
//                                 focusColor: Colors.white,
//                                 labelStyle: TextStyle(color: Colors.white),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                               ),
//                               style: const TextStyle(color: Colors.white),
//                               enabled: true, // Pre-filled, disable editing
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ), // Increased spacing to match image
//                             // Password Field
//                             TextField(
//                               obscureText: true,
//                               cursorColor: Colors.white,
//                               controller: controller.password.value,
//                               decoration: const InputDecoration(
//                                 labelText: 'Enter Password',
//                                 fillColor: Colors.white,
//                                 focusColor: Colors.white,

//                                 labelStyle: TextStyle(color: Colors.white),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                               ),
//                               style: const TextStyle(color: Colors.white),
//                             ),

//                             const SizedBox(height: 10),

//                             TextField(

//                               cursorColor: Colors.white,
//                               controller: controller.companyName.value,
//                               decoration: const InputDecoration(
//                                 labelText: 'Company Name',
//                                 fillColor: Colors.white,
//                                 focusColor: Colors.white,

//                                 labelStyle: TextStyle(color: Colors.white),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                               ),
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                             const SizedBox(height: 10),
//                             Obx(
//                               () => DropdownButtonFormField<String>(
//                                 decoration: InputDecoration(
//                                   labelText: "Select Role",
//                                   labelStyle: const TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                   fillColor: Colors.white,
//                                   focusColor: Colors.white,
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                   focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(color: Colors.white),
//                                   ),
//                                 ),
//                                 dropdownColor: const Color(0xFF2762A1),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   // fontWeight: FontWeight.bold,
//                                 ),
//                                 icon: const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.white,
//                                 ),
//                                 iconSize: 24,
//                                 isExpanded: true,
//                                 hint: const Text(
//                                   "Select Role",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     // fontWeight: FontWeight.bold,
//                                   ),

//                                   // textcolor: Colors.white,
//                                 ),
//                                 value:
//                                     controller
//                                         .selectedRole
//                                         .value, // can be null safely
//                                 items: const [
//                                   DropdownMenuItem(
//                                     value: "CFO",
//                                     child: Text("CFO"),
//                                   ),
//                                   DropdownMenuItem(
//                                     value: "Director",
//                                     child: Text("Director"),
//                                   ),
//                                 ],
//                                 onChanged: (value) {
//                                   controller.selectedRole.value =
//                                       value; // no need for ?? ''
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//                             // Adjusted spacing
//                             // Login Button
//                             ElevatedButton(
//                               onPressed: () {
//                                 controller.register();
//                                 // Get.snackbar('Login', 'Login button pressed!');
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 minimumSize: const Size(double.infinity, 50),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 backgroundColor: Colors.white,
//                                 foregroundColor: const Color(0xFF2762A1),
//                               ),
//                               child: const Text('Register'),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ), // Bottom padding to match image
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 // Forgot Password Button
//                                 // TextButton(
//                                 //   onPressed: () {
//                                 //     Get.toNamed(Routes.FORGOTPASSWORD);
//                                 //   },
//                                 //   child: const Text(
//                                 //     'Forgot Password?',
//                                 //     style: TextStyle(
//                                 //       color: Colors.white,
//                                 //       fontSize: 16,
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 // // Register Button
//                                 TextButton(
//                                   onPressed: () {
//                                     Get.toNamed(Routes.AUTH);
//                                   },
//                                   child: const Text(
//                                     'Login',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize AuthController using Get.put()
    // final AuthController authController = Get.put(AuthController());
    final _formKey = GlobalKey<FormState>();
    final List<String> roles = ['viewer', 'editor'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20.0),
                // Company Name Text Field
                TextFormField(
                  controller: controller.companyName.value,
                  decoration: InputDecoration(
                    hintText: 'Company Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  validator:
                      (val) => val!.isEmpty ? 'Enter a company name' : null,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: controller.name.value,
                  decoration: InputDecoration(
                    hintText: ' Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter a  name' : null,
                ),
                const SizedBox(height: 20.0),
                // Email Text Field
                TextFormField(
                  controller: controller.email.value,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  validator:
                      (val) =>
                          !GetUtils.isEmail(val!)
                              ? 'Enter a valid email'
                              : null,
                ),
                const SizedBox(height: 20.0),
                // Password Text Field
                TextFormField(
                  controller: controller.password.value,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  obscureText: true,
                  validator:
                      (val) =>
                          val!.length < 6
                              ? 'Password must be at least 6 characters'
                              : null,
                ),
                const SizedBox(height: 20.0),
                // Role Dropdown
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectRole.value,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    items:
                        controller.role.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    // roles.map((String value) {
                    //   return DropdownMenuItem<String>(
                    //     value: value,
                    //     child: Text(value),
                    //   );
                    // }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.selectRole(newValue);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                // Register Button and Loading Indicator
                Obx(
                  () =>
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Register now',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.signUp();
                              }
                            },
                          ),
                ),
                const SizedBox(height: 12.0),
                // Error Text
                Obx(
                  () => Text(
                    controller.error.value,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Navigation to Login Screen
                TextButton(
                  child: const Text("Already have an account? Login"),
                  onPressed: () {
                    controller.clearFields();
                    Get.offAllNamed(Routes.AUTH); // Use GetX for navigation
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

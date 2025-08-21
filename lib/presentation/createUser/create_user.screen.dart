import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../bottomNave/bottom_nave.screen.dart';
import 'controllers/create_user.controller.dart';

class CreateUserScreen extends GetView<CreateUserController> {
  const CreateUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Company User'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNaveScreen(),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Header Section
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Adding user to company:\n${controller.userInfo.value.companyName ?? "..."}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),

              // Email Input Field
              TextFormField(
                controller: controller.nameController,
                decoration: _buildInputDecoration('New User Name', Icons.person),
                keyboardType: TextInputType.text,
                // validator: (val) => !GetUtils.isEmail(val!) ? 'Please enter a valid email' : null,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: controller.newUserEmailController,
                decoration: _buildInputDecoration('New User Email', Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => !GetUtils.isEmail(val!) ? 'Please enter a valid email' : null,
              ),
              const SizedBox(height: 20.0),

              // Password Input Field
              TextFormField(
                controller: controller.newUserPasswordController,
                decoration: _buildInputDecoration('New User Password', Icons.lock_outline),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Password must be at least 6 characters' : null,
              ),
              const SizedBox(height: 20.0),

              // Role Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: controller.role.value,
                decoration: _buildInputDecoration('Select Role', Icons.person_outline),
                items: controller.roles.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.capitalizeFirst!),
                  );
                }).toList(),
                onChanged: controller.setRole,
              )),
              const SizedBox(height: 40.0),

              // Submit Button and Loading Indicator
              // Obx(() => controller.isLoading.value
              //     ? const Center(child: CircularProgressIndicator())
              //     : ElevatedButton.icon(
              //   icon: const Icon(Icons.person_add_alt_1),
              //   label: const Text('CREATE USER'),
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: Theme.of(context).primaryColor,
              //       padding: const EdgeInsets.symmetric(vertical: 15),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
              //   ),
              //   onPressed: controller.createUser,
              // )),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  onPressed:controller.createUser,
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
                    'CREATE USER',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),

              // Error Message Display
              Obx(() => Text(
                controller.error.value,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for consistent input field styling
  InputDecoration _buildInputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.grey[200],
    );
  }
}

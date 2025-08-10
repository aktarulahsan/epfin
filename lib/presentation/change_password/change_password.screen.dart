import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/change_password.controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangePasswordScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChangePasswordScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

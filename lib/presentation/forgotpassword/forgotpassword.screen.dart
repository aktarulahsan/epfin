import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/forgotpassword.controller.dart';

class ForgotpasswordScreen extends GetView<ForgotpasswordController> {
  const ForgotpasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForgotpasswordScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ForgotpasswordScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

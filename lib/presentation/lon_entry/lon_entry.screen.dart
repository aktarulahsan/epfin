import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/lon_entry.controller.dart';

class LonEntryScreen extends GetView<LonEntryController> {
  const LonEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LonEntryScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LonEntryScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

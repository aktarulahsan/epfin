import 'package:epfin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import '../../auth/auth.screen.dart';

class LonEntryController extends GetxController {
  //TODO: Implement LonEntryController
  var shortCodeList = ['EEL', 'ABC', 'XYZ'].obs;
  var selectedShortCode = 'EEL'.obs;

  var balanceDate = DateTime.now().obs;

  var totalLoan = TextEditingController().obs;
  var overDue = TextEditingController().obs;
  var ss = TextEditingController().obs;
  var bl = TextEditingController().obs;
  var status = TextEditingController().obs;

  void pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: balanceDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      balanceDate.value = picked;
    }
  }

  String get formattedDate =>
      DateFormat('dd/MM/yyyy').format(balanceDate.value);


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() async {
    // await storage.deleteAll();
    prefs.remove('userInfo');
    Get.offAll(const AuthScreen(), binding: AuthControllerBinding());
  }
  final showDrawer = false.obs;
  void toggleDrawer() {
    showDrawer.value = !showDrawer.value;
  }
}

import 'package:epfin/infrastructure/dal/model/base_response.dart';
import 'package:epfin/infrastructure/dal/model/company_model.dart';
import 'package:epfin/infrastructure/dal/services/lon_entry.service.dart';
import 'package:epfin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../auth/auth.screen.dart';

import 'package:epfin/infrastructure/dal/model/base_response.dart';
import 'package:epfin/infrastructure/dal/model/company_model.dart';
import 'package:epfin/infrastructure/dal/model/statement.model.dart';
import 'package:epfin/infrastructure/dal/services/lon_entry.service.dart';
import 'package:epfin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import '../../auth/auth.screen.dart';

class LonEntryController extends GetxController {
  var shortCodeList = ['EEL', 'ABC', 'XYZ'].obs;
  var selectedShortCode = ''.obs;
  var balanceDate = DateTime.now().obs;
  var balanceDateController = TextEditingController().obs; // Added for balance date
  var totalLoan = TextEditingController().obs;
  var overDue = TextEditingController().obs;
  var ss = TextEditingController().obs;
  var bl = TextEditingController().obs;
  var status = TextEditingController().obs;
  var companyList = <CompanyModel>[].obs;
  var selectShortCode = CompanyModel().obs;
  var isLoading = 0.obs;
  var id = 0.obs;
  var responseSMS = ''.obs;
  var responseType = 0.obs;

  @override
  void onInit() {
    super.onInit();
    balanceDateController.value.text = DateFormat('dd/MM/yyyy').format(balanceDate.value);
    getCompany();
    // Check if a StatementModel is passed as an argument
    if (Get.arguments is StatementModel) {
      _prefillForm(Get.arguments as StatementModel);
    }
  }

  void _prefillForm(StatementModel model) {
    id.value = model.id ??0;
    selectedShortCode.value = model.shortCode ?? '';
    balanceDate.value = model.balanceDate ?? DateTime.now();
    balanceDateController.value.text = DateFormat('dd/MM/yyyy').format(balanceDate.value);
    totalLoan.value.text = formatToIndianCurrency(model.totalLone ?? 0);
    overDue.value.text = formatToIndianCurrency(model.overDue ?? 0);
    ss.value.text = formatToIndianCurrency(model.ss ?? 0);
    bl.value.text = formatToIndianCurrency(model.bl ?? 0);
    status.value.text = model.status ?? '';
    // Set the selected company
    if (companyList.isNotEmpty) {
      selectShortCode.value = companyList
          .firstWhere((company) => company.shortCode == model.shortCode, orElse: () => CompanyModel());
    }
  }

  String formatToIndianCurrency(double value) {
    final format = NumberFormat.decimalPattern('en_IN');
    return format.format(value);
  }

  void pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: balanceDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      balanceDate.value = picked;
      balanceDateController.value.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  String get formattedDate => DateFormat('dd/MM/yyyy').format(balanceDate.value);

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    balanceDateController.value.dispose();
    totalLoan.value.dispose();
    overDue.value.dispose();
    ss.value.dispose();
    bl.value.dispose();
    status.value.dispose();
    super.onClose();
  }

  void logout() async {
    prefs.remove('userInfo');
    Get.offAll(const AuthScreen(), binding: AuthControllerBinding());
  }

  final showDrawer = false.obs;
  void toggleDrawer() {
    showDrawer.value = !showDrawer.value;
  }

  Future<void> getCompany() async {
    isLoading.value = 1;
    var mail = prefs.get('mail');
    await LonEntryService.getCompany(mail).then((value) async {
      BaseResponse responses = BaseResponse();
      try {
        responses = BaseResponse.fromJson(value.data);
        if (responses.dataList != null) {
          companyList.value = companyModelListFromJson(responses.dataList);
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading.value = 0;
      }
    });
  }

  Future<void> submitData() async {
    isLoading.value = 1;
    var ids = id.value;
    var shortCodeVal = selectedShortCode.value;
    var totalLoansVal = double.tryParse(totalLoan.value.text.replaceAll(',', '')) ?? 0;
    var overDuesVal = double.tryParse(overDue.value.text.replaceAll(',', '')) ?? 0;
    var sssVal = double.tryParse(ss.value.text.replaceAll(',', '')) ?? 0;
    var blsVal = double.tryParse(bl.value.text.replaceAll(',', '')) ?? 0;
    var statussVal = status.value.text;

    await LonEntryService.submitData(
      id: ids,
      shortCode: shortCodeVal,
      totalLoan: totalLoansVal,
      overDue: overDuesVal,
      ss: sssVal,
      bl: blsVal,
      status: statussVal,
      balanceDate: balanceDate.value,
      entryDateTime: DateTime.now(),
      hostName: "MyHostName",
    ).then((value) async {
      BaseResponse responses = BaseResponse();
      try {
        responses = BaseResponse.fromJson(value.data);
        if (responses.success == true) {
          responseSMS.value = responses.message!;
          responseType.value = 0;
          // {"message":"A loan record with the given ShortCode and BalanceDate already exists.","success":false,"data":null,"dataList":null}

          // Get.defaultDialog(
          //   title: "Success",
          //   middleText: "Loan entry submitted successfully!",
          //   textConfirm: "OK",
          //   confirmTextColor: Colors.white,
          //   onConfirm: () {
          //     Get.back(); // Close dialog
          //     Get.offNamed(Routes.HOME); // Navigate back to HomeScreen
          //   },
          // );
        } else {
          responseType.value = 1;
          responseSMS.value = responses.message!;
          // Get.defaultDialog(
          //   title: "Warning",
          //   middleText: responses.message ?? "Something went wrong!",
          //   textConfirm: "OK",
          //   confirmTextColor: Colors.white,
          //   onConfirm: () => Get.back(),
          // );
        }
      } catch (e) {
        responseType.value = 2;
        responseSMS.value = responses.message!;
        print("Parse Error: $e");
        // Get.defaultDialog(
        //   title: "Warning",
        //   middleText: "Invalid server response.",
        //   textConfirm: "OK",
        //   confirmTextColor: Colors.white,
        //   onConfirm: () => Get.back(),
        // );
      } finally {
        isLoading.value = 0;
      }
    }).catchError((e) {
      isLoading.value = 0;
      print("Submit Error: $e");
      Get.defaultDialog(
        title: "Warning",
        middleText: "Failed to submit data.",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () => Get.back(),
      );
    });
  }
}
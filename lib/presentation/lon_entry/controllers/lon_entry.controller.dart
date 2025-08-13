import 'package:epfin/infrastructure/dal/model/base_response.dart';
import 'package:epfin/infrastructure/dal/model/company_model.dart';
import 'package:epfin/infrastructure/dal/services/lon_entry.service.dart';
import 'package:epfin/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import '../../auth/auth.screen.dart';

import 'package:epfin/infrastructure/dal/model/statement.model.dart';

class LonEntryController extends GetxController {
  var shortCodeList = ['EEL', 'ABC', 'XYZ'].obs;
  var selectedShortCode = ''.obs;
  var selectedShortCodeList = [].obs;
  var balanceDate = DateTime.now().obs;
  var balanceDateController =
      TextEditingController().obs; // Added for balance date
  var totalLoan = TextEditingController().obs;
  var overDue = TextEditingController().obs;
  var ss = TextEditingController().obs;
  var bl = TextEditingController().obs;
  var status = TextEditingController().obs;
  var companyList = <CompanyModel>[].obs;
  // var selectShortCode = CompanyModel().obs;
  var selectShortCode = ''.obs;
  var statusList = [].obs;
  var selectStatus = ''.obs;
  var isLoading = 0.obs;
  var isLoading2 = 0.obs;
  var id = 0.obs;
  var responseSMS = ''.obs;
  var responseMessage = ''.obs;
  var responseType = 0.obs;
  var shortCode = ''.obs;

  var invalidFields = <String>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    balanceDateController.value.text = DateFormat(
      'dd/MM/yyyy',
    ).format(balanceDate.value);
      getCompany();
    await getStatusList();
    // Check if a StatementModel is passed as an argument
    if (Get.arguments is StatementModel) {
      _prefillForm(Get.arguments as StatementModel);
    }
  }

  void _prefillForm(StatementModel model) {
    id.value = model.id ?? 0;
    selectedShortCode.value = model.shortCode ?? '';
    shortCode.value = model.shortCode ?? '';
    balanceDate.value = model.balanceDate ?? DateTime.now();
    balanceDateController.value.text = DateFormat(
      'dd/MM/yyyy',
    ).format(balanceDate.value);
    totalLoan.value.text = formatToIndianCurrency(model.totalLone ?? 0);
    overDue.value.text = formatToIndianCurrency(model.overDue ?? 0);
    ss.value.text = formatToIndianCurrency(model.ss ?? 0);
    bl.value.text = formatToIndianCurrency(model.bl ?? 0);
    status.value.text = model.status ?? '';
    selectStatus.value = model.status ?? '';
    // Set the selected company
    if (companyList.isNotEmpty) {
      // selectShortCode.value = companyList.firstWhere(
      //   (company) => company.shortCode == model.shortCode,
      //   orElse: () => CompanyModel(),
      // );
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
      balanceDateController.value.text = DateFormat(
        'dd/MM/yyyy',
      ).format(picked);
    }
  }

  String get formattedDate =>
      DateFormat('dd/MM/yyyy').format(balanceDate.value);

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // balanceDateController.value.dispose();
    // selectedShortCode.value = '';
    // totalLoan.value.dispose();
    // overDue.value.dispose();
    // ss.value.dispose();
    // bl.value.dispose();
    // status.value.dispose();
    balanceDate.value = DateTime.now();
    balanceDateController.value.clear();
    totalLoan.value.clear();
    selectedShortCode.value = '';
    overDue.value.clear();
    ss.value.clear();
    bl.value.clear();
    status.value.clear();

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

          selectedShortCodeList.value = companyList.map((e) => e.shortCode.toString()).toList();

          selectShortCode.value = selectedShortCodeList.first;
          selectedShortCode.value = selectShortCode.value ?? '';
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading.value = 0;
      }
    });
  }

  Future<void> getStatusList() async {
    isLoading2.value = 1;

    await LonEntryService.getStatusList().then((value) async {
      BaseResponse responses = BaseResponse();
      try {
        responses = BaseResponse.fromJson(value.data);
        if (responses.dataList != null) {
          companyList.value = companyModelListFromJson(responses.dataList);
          // statusList.value =
          //     responses.dataList.map((e) => e.toString()).toList();
          statusList.value =
              responses.dataList.map((e) => e['name'].toString()).toList();
          selectStatus.value = statusList.isNotEmpty ? statusList.first : '';
          status.value.text = selectStatus.value;
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading2.value = 0;
      }
    });
  }

  Future<void> submitData() async {
    isLoading.value = 1;
    var ids = id.value;
    var shortCodeVal = selectedShortCode.value;
    var totalLoansVal =
        double.tryParse(totalLoan.value.text.replaceAll(',', '')) ?? 0;
    var overDuesVal =
        double.tryParse(overDue.value.text.replaceAll(',', '')) ?? 0;
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
        )
        .then((value) async {
          BaseResponse responses = BaseResponse();
          try {
            responses = BaseResponse.fromJson(value.data);
            if (responses.success == true) {
              responseSMS.value = responses.message!;
              responseType.value = 0;
              responseMessage.value =
                  shortCode.value.isNotEmpty
                      ? 'Data Update Successfully'
                      : 'Data Save Successfully';

              // if (responseType.value == 0) {

              // } else if (responseType.value == 1) {
              //   responseMessage.value = 'Data Update Failed';
              // } else {
              //   responseMessage.value = 'Something Wrong';
              // }
            } else {
              responseType.value = 1;
              responseSMS.value = responses.message!;
              responseMessage.value = 'Data Update Failed';
            }
          } catch (e) {
            responseType.value = 2;
            responseSMS.value = responses.message!;
            responseMessage.value = 'Something Wrong';
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
        })
        .catchError((e) {
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

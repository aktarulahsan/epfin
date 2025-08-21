import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epfin/infrastructure/dal/model/base_response.dart';
import 'package:epfin/infrastructure/dal/model/login.model.dart';
import 'package:epfin/infrastructure/dal/model/statement.model.dart';
import 'package:epfin/infrastructure/dal/services/home.service.dart';
import 'package:epfin/main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure/navigation/bindings/controllers/auth.controller.binding.dart';
import '../../auth/auth.screen.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // final storage = const FlutterSecureStorage();
  final name = ''.obs;
  final email = ''.obs;
  final greetingText = ''.obs;
  final selectedTab = 'Loan Latest Balance'.obs;
  final showDrawer = false.obs;

  var user = LoginModel().obs;

  var date = "".obs;
  var isLoading = 0.obs;

  var statementList = <StatementModel>[].obs;
  var statementObject = StatementModel().obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    super.onInit();
    await _initializeData();
  }

  Future<void> _initializeData() async {
    // var a = await prefs.get('userInfo');
    // Map<String, dynamic> userInfo = jsonDecode(prefs.getString('userInfo') ?? '{}');
    user.value = LoginModel.fromJson(
      jsonDecode(prefs.getString('userInfo') ?? '{}'),
    );
    prefs.remove('mail');
    prefs.setString('mail', user.value.email!);
    final token = user.value.token;
    // name.value = (await storage.read(key: 'Name')) ?? '';
    email.value = user.value.email! ?? "";
    name.value = user.value.name ?? "";
    date.value = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    getStatement();
    user.value.userTypeName == 'web'
        ? await fetchTodaysLoanData()
        : await getStatement();

    final hour = DateTime.now().hour;
    if (hour < 12) {
      greetingText.value = 'Good Morning,';
    } else if (hour < 17) {
      greetingText.value = 'Good Afternoon,';
    } else {
      greetingText.value = 'Good Evening,';
    }
  }

  Future<void> getStatement() async {
    isLoading.value = 1;
    var mail = prefs.get('mail');

    await HomeService.getStatement(mail).then((value) async {
      BaseResponse responses = BaseResponse();
      try {
        responses = BaseResponse.fromJson(value.data);
        if (responses.dataList != null) {
          statementList.value = statementModelListFromJson(responses.dataList);
        } else {}
      } catch (e) {
        print(e);
      } finally {
        isLoading.value = 0;
      }
    });
  }

  Future<StatementModel> getStatementByShortCode(
    var shortCode,
    var date,
  ) async {
    // isLoading.value = 1;
    // var mail = prefs.get('mail');

    await HomeService.getStatementByShortCode(shortCode, date).then((
      value,
    ) async {
      BaseResponse responses = BaseResponse();
      try {
        responses = BaseResponse.fromJson(value.data);
        if (responses.data != null) {
          statementObject.value = StatementModel.fromJson(responses.data);
        } else {
          statementObject.value = StatementModel();
        }
      } catch (e) {
        print(e);
      } finally {
        // isLoading.value = 0;
      }
    });
    return statementObject.value;
  }

  /// Fetches today's loan data from Firestore.
  Future<void> fetchTodaysLoanData() async {
    if (user.value == null) {
      return;
    }

    try {
      final today = DateTime.now();
      final docId = DateFormat('yyyy-MM-dd').format(today);
      final companyName = user.value.companyName;

      final docRef = _firestore
          .collection('companies')
          .doc(companyName)
          .collection('loanHistory')
          .doc(docId);

      final doc = await docRef.get();

      if (doc.exists) {
        final data = doc.data()!;
        // final List<dynamic> rawList = data['statements'] ?? [];
        StatementModel model = StatementModel.fromJson(data);

        statementList.value = [model];
        //     rawList.map((e) => StatementModel.fromJson(e)).toList();
      } else {
        statementList.value = [];
      }
    } catch (e) {
      print("Fetch Error: $e");
      statementList.value = [];
    }
  }

  void selectTab(String tab) {
    selectedTab.value = tab;
  }

  void logout() async {
    // await storage.deleteAll();
    prefs.remove('userInfo');
    Get.offAll(const AuthScreen(), binding: AuthControllerBinding());
  }

  void toggleDrawer() {
    showDrawer.value = !showDrawer.value;
  }

  @override
  void onReady() {
    print("object");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void increment() => count.value++;
}

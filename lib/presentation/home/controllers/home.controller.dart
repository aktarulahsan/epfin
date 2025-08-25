import 'dart:convert';
import 'dart:math';

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


  var grandTotalLone = 0.0.obs;
  var grandTotalOverDue = 0.0.obs;
  var grandTotalSS = 0.0.obs;
  var grandTotalBL = 0.0.obs;
  var grandTotalData = StatementModel().obs;

  final List<int> professionalColorCodes = [
    0xFF0078FF, // Dark blue-gray
    0xFF34495E, // Charcoal blue
    0xFF2C5282, // Navy blue
    0xFF4A5568, // Slate gray
    0xFF2D3748, // Dark gray-blue
    0xFF34495E, // Charcoal blue
    0xFF2C5282, // Navy blue
    0xFF4A5568, // Slate gray
    0xFF2D3748, // Dark gray-blue
    0xFF1A365D, // Deep navy
    0xFF2D3748, // Dark slate
    0xFF4C6EF5, // Professional blue
    0xFF495057, // Muted gray
    0xFF343A40, // Dark charcoal

  ];
  var itemColors = <int>[].obs;


  // void generateRandomColors(int itemCount) {
  //   final random = Random();
  //   itemColors.clear();
  //
  //   for (int i = 0; i < itemCount; i++) {
  //     itemColors.add(professionalColorCodes[random.nextInt(professionalColorCodes.length)]);
  //   }
  // }
  //
  // // Function to get color for specific index
  int getColorForIndex(int index) {
      print(index);
    if (index < itemColors.length) {
      print(itemColors[index]);
      return itemColors[index];
    }

    // Return default color if index is out of bounds
    return itemColors[0];
  }
  //
  // // Function to refresh colors
  // void refreshColors() {
  //   if (itemColors.isNotEmpty) {
  //     generateRandomColors(itemColors.length);
  //   }
  // }


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
    itemColors.value = professionalColorCodes.toSet().toList();
    itemColors.shuffle(Random());
    prefs.remove('mail');
    prefs.setString('mail', user.value.email!);
    final token = user.value.token;
    // name.value = (await storage.read(key: 'Name')) ?? '';
    email.value = user.value.email! ?? "";
    name.value = user.value.name ?? "";
    date.value = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    // getStatement();
    user.value.userTypeName == 'web'
        ? await fetchTodayLoanData()
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

          for (var element in statementList) {
            grandTotalLone.value += element.totalLone!;
            grandTotalOverDue.value += element.overDue!;
            grandTotalSS.value += element.ss!;
            grandTotalBL.value += element.bl!;
          }
          if(statementList.isNotEmpty){

            grandTotalData.value.totalLone = grandTotalLone.value;
            grandTotalData.value.overDue = grandTotalOverDue.value;
            grandTotalData.value.ss = grandTotalSS.value;
            grandTotalData.value.bl = grandTotalBL.value;
            grandTotalData.value.status = '';
            grandTotalData.value.companyName = 'Grand Total';
            grandTotalData.value.balanceDate = DateTime.now().subtract(const Duration(days: 1));
            // grandTotalData.value.companyName

            statementList.add(grandTotalData.value);
          }

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

    await HomeService.getStatementByShortCode(shortCode, date).then((value) async {
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
  Future<void> fetchTodayLoanData() async {
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

import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // final storage = const FlutterSecureStorage();
  final name = ''.obs;
  final email = ''.obs;
  final greetingText = ''.obs;
  final selectedTab = 'Loan Latest Balance'.obs;
  final showDrawer = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _initializeData();
  }

  Future<void> _initializeData() async {
    // final token = await storage.read(key: 'Token');
    // name.value = (await storage.read(key: 'Name')) ?? '';
    // email.value = (await storage.read(key: 'Email')) ?? '';

    final hour = DateTime.now().hour;
    if (hour < 12) {
      greetingText.value = 'Good Morning,';
    } else if (hour < 17) {
      greetingText.value = 'Good Afternoon,';
    } else {
      greetingText.value = 'Good Evening,';
    }

    // if (token == null || token.isEmpty) {
    //   Get.offAllNamed('/login');
    // }
  }

  void selectTab(String tab) {
    selectedTab.value = tab;
  }

  void logout() async {
    // await storage.deleteAll();
    Get.offAllNamed('/');
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

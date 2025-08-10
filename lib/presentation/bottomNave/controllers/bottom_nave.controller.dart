import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class BottomNaveController extends GetxController {
  var selectedIndex = 1.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void onItemTapped(int index) {
    changeIndex(index);

    if (index == 0) {
      Get.offAllNamed(Routes.CHANGE_PASSWORD);
    } else if (index == 1) {
      Get.offAllNamed(Routes.HOME);
    } else if (index == 2) {
      Get.offAllNamed(Routes.PROFILE);
    }
  }

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
}

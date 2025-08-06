import 'package:epfin/infrastructure/navigation/bindings/controllers/home.controller.binding.dart';
import 'package:epfin/presentation/home/home.screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAll(() => const HomeScreen(), binding: HomeControllerBinding());
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

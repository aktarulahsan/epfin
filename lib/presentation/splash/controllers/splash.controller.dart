import 'package:epfin/infrastructure/navigation/bindings/controllers/home.controller.binding.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/presentation/home/home.screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {


  bool _hasNavigated = false;

  Future<void> goto()async{
    print('SplashController: onReady called');
    if (!_hasNavigated) {
      _hasNavigated = true;
    await  Future.delayed(const Duration(seconds: 4), () {
        try {
          print('SplashController: Navigating to HomeScreen');
          Get.offAllNamed(Routes.HOME);
        } catch (e, stackTrace) {
          print('SplashController: Navigation error: $e');
          print('StackTrace: $stackTrace');
        }
      });
    }
  }


@override
  void onInit() {
    super.onInit();
    print('SplashController: onInit called');

  }

 @override
  void onReady()   {
    super.onReady();
      goto();
    print('SplashController: onReady called');

  }
}

import 'package:get/get.dart';

import '../../../../presentation/forgotpassword/controllers/forgotpassword.controller.dart';

class ForgotpasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotpasswordController>(
      () => ForgotpasswordController(),
    );
  }
}

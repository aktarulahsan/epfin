import 'package:get/get.dart';

import '../../../../presentation/change_password/controllers/change_password.controller.dart';

class ChangePasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(),
    );
  }
}

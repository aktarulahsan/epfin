import 'package:get/get.dart';

import '../../../../presentation/createUser/controllers/create_user.controller.dart';

class CreateUserControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUserController>(
      () => CreateUserController(),
    );
  }
}

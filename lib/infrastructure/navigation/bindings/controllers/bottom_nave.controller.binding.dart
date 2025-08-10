import 'package:get/get.dart';

import '../../../../presentation/bottomNave/controllers/bottom_nave.controller.dart';

class BottomNaveControllerBinding extends Bindings {
  // @override
  // void dependencies() {
  //   Get.lazyPut<BottomNaveController>(() => BottomNaveController());
  // }
  @override
  void dependencies() {
    Get.put(BottomNaveController(), permanent: true);
  }
}

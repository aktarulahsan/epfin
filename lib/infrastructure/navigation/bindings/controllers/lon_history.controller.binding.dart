import 'package:get/get.dart';

import '../../../../presentation/lon_history/controllers/lon_history.controller.dart';

class LonHistoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LonHistoryController>(
      () => LonHistoryController(),
    );
  }
}

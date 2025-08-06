import 'package:get/get.dart';

import '../../../../presentation/lon_entry/controllers/lon_entry.controller.dart';

class LonEntryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LonEntryController>(
      () => LonEntryController(),
    );
  }
}

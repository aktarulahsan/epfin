import 'dart:convert';

import 'package:epfin/infrastructure/dal/model/login.model.dart';
import 'package:epfin/main.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  var user = LoginModel().obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    var a = await prefs.get('userInfo');
    Map<String, dynamic> userInfo = jsonDecode(
      prefs.getString('userInfo') ?? '{}',
    );

    try {
      if (a != null) {
        user.value = LoginModel.fromJson(userInfo);
      }
    } catch (e) {
      print(e.toString());
    }
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

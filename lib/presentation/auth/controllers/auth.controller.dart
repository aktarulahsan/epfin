import 'dart:convert';

import 'package:epfin/infrastructure/dal/model/login.model.dart';
import 'package:epfin/infrastructure/dal/services/auth.service.dart';
import 'package:epfin/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:epfin/main.dart';
import 'package:epfin/presentation/auth/auth.screen.dart';
import 'package:epfin/presentation/home/home.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/dal/model/base_response.dart';
import '../../../infrastructure/dal/model/login.model.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

 var email = TextEditingController().obs;
 var password = TextEditingController().obs;


  @override
  void onInit() {
    email.value.text = prefs.getString('mail') ?? "";
    super.onInit();
  }

 void checkLoginStatus() async {
   var box = prefs;
   LoginModel m = LoginModel();
   var a = box.get('userInfo');
   // email.value.text = box.getString('mail')! ??"";


   if (a != null) {
     m = loginResponseFromJson(a.toString());
   }
   // print(m.toJson());

     await AuthService.logIn(email.value.text, password.value.text).then((value) async {
       BaseResponse responses = BaseResponse();
       responses = BaseResponse.fromJson(value.data);
       if (responses.data !=null) {
         //
         box.setString('userInfo', jsonEncode(responses.data));
         // box.setString('mail', responses.data.)
         Get.offAll(HomeScreen(), binding: HomeControllerBinding());
       } else {

         // box.remove('userInfo');
         // Get.offAll(const AuthScreen(), binding: AuthControllerBinding());
       }
     });

     // Get.offAll(() =>   HomeView(), binding: HomeBinding());

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

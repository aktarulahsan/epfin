import 'dart:convert';

import 'package:epfin/infrastructure/navigation/bindings/controllers/home.controller.binding.dart';
import 'package:epfin/infrastructure/navigation/routes.dart';
import 'package:epfin/main.dart';
import 'package:epfin/presentation/home/home.screen.dart';
import 'package:get/get.dart';

import '../../../infrastructure/dal/model/login.model.dart';

class SplashController extends GetxController {


  bool _hasNavigated = false;

  var user = LoginModel().obs;

  Future<void> getUser() async {
    var a = await  prefs.get('userInfo');
    Map<String, dynamic> userInfo = jsonDecode(prefs.getString('userInfo') ?? '{}');


    try{
      if(a!=null){
        user.value = LoginModel.fromJson(userInfo);
      }
    }catch(e){
      print(e.toString());
    }
    goto();
  }

  Future<void> goto()async{
    print('SplashController: onReady called');
    if (!_hasNavigated) {
      _hasNavigated = true;
    await  Future.delayed(const Duration(seconds: 4), () {
        try {
          print('SplashController: Navigating to HomeScreen');
          if(user.value.userId !=null){
            Get.offAllNamed(Routes.HOME);
          }else{
            Get.offAllNamed(Routes.AUTH);
          }

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

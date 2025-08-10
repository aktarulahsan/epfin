import 'package:epfin/constant/asset_images.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});
  // If you need to perform actions on widget load, use a Future in build or convert to StatefulWidget.

  // void goto(){
  //   Future.delayed(const Duration(seconds: 4), () {
  //     try {
  //       print('SplashController: Navigating to HomeScreen');
  //       Get.offAllNamed(Routes.HOME);
  //     } catch (e, stackTrace) {
  //       print('SplashController: Navigation error: $e');
  //       print('StackTrace: $stackTrace');
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    controller.getUser();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(decoration: const BoxDecoration(color: Colors.blue)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 300.0,
                  child: Image.asset(
                    AppAssetsImages.logo,
                    height: 100,
                    width: 150,
                    // color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:epfin/constant/asset_images.dart';
import 'package:epfin/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:epfin/presentation/home/home.screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});
  // If you need to perform actions on widget load, use a Future in build or convert to StatefulWidget.

  @override
  void initState() {
    super.initState();
    // permissionServiceCall();
    Future.delayed(const Duration(seconds: 4), () async {
      Get.offAll(HomeScreen(), binding: HomeControllerBinding());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(decoration: const BoxDecoration(color: Colors.white)),
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
                    AppAssetsImages.logo4,
                    height: 100,
                    width: 150,
                    // fit: BoxFit.cover,
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

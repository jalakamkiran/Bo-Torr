import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/res.dart';
import 'package:libgen/routes/app_routes.dart';
import 'package:rive/rive.dart';
import 'splash_screen_logic.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  final logic = Get.find<SplashScreenLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313131),
      body: RiveAnimation.asset(Res.bo_torr),
    );
  }
}

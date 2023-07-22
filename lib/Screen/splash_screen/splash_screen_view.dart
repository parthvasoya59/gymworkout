import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/widget/custom_button.dart';

import '../../Constant/app_image.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/progress_bar.dart';
import 'splash_screen_logic.dart';

class SplashScreenWidget extends GetView<SplashScreenLogic> {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SplashScreenLogic>();
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: cBlack,
      body: Center(
        child: Container(
          width: w * 0.3,
          height: w * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(Assets.logo),
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain
            )
          ),
        )
      ),
    );
  }
}

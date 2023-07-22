import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/AppRoute/app_route.dart';

import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';

class SplashScreenLogic extends GetxController {

  bool isDashboard = false;
  Future getRedirect() async {
    // we check is goal selected or not based on that we redirect, because it's last screen for user form
    int t = await Preference().readInt(Const.prefGoalIndex) ?? 10;
    debugPrint("getRedirect ==> t : ${t}");

    if(t != 10){
      isDashboard = true;
    }else{
      isDashboard = false;
    }
    debugPrint("getRedirect ==> isDashboard : ${isDashboard}");

    Timer(const Duration(seconds: 3), () {
      if(isDashboard) {
        Get.offNamed(AppRoutes.dashboardScreen);
      } else {
        Get.offNamed(AppRoutes.genderSelScreen);
      }
    });
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // await getRedirect();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}

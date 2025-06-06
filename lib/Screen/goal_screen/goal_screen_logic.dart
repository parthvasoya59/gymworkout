import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class GoalScreenLogic extends GetxController {

  RxInt goalIndex = 0.obs;
  //0 = Muscle Gain, 1 = Weight Loss, 2 = Fitness, 3 = Wellness


  onNextGoal() async {
    debugPrint('onNextGoal => goalIndex ${goalIndex.value}');
    await Preference().saveInt(Const.prefGoalIndex, goalIndex.value);
    //go to next screen
    Get.toNamed(AppRoutes.loadingScreen);
  }


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
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


/*
Underweight = <18.5
Normal weight = 18.5–24.9
Overweight = 25–29.9
Obesity = BMI of 30 or greater
 */

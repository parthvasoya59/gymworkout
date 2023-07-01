import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class CalculatorScreenLogic extends GetxController {

  RxBool isMale = true.obs;
  RxInt height = 160.obs;
  RxDouble weight = 45.0.obs;
  RxInt age = 25.obs;
  RxString selectedActivityLevel = "Moderately Active".obs;
  RxString selectedGaol = "Weight Loss".obs;

  List<String> activityLevelList = [
    "Sedentary Active",
    "Lightly Active",
    "Moderately Active",
    "Very Active",
    "Extremely Active",
  ];

  List<String> goalList = [
    "Muscle Gain",
    "Maintain Weight",
    "Weight Loss"
  ];

  onClickMale(){
    isMale.value = true;
  }

  onClickFemale(){
    isMale.value = false;
  }


  onCalculate(){
    debugPrint("onCalculate --->");
    Get.toNamed(AppRoutes.resultScreen);
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

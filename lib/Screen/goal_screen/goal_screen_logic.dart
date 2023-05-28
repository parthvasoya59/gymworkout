import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class GoalScreenLogic extends GetxController {

  RxDouble bmiValue = 0.00.obs;
  RxString keyForMap = "".obs;
  RxString bmiString = "".obs;


  onNextBmi() async {
    debugPrint('onNextBmi => bmiValue ${bmiValue.value}');
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/Screen/home_screen/home_screen_logic.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class ProfileScreenLogic extends GetxController {

  var homeCon = Get.find<HomeScreenLogic>();

  RxDouble bmiValue = 0.00.obs, weightValue = 45.0.obs, heightValue = 130.0.obs;
  RxString keyForMap = "".obs, goal = "".obs;

  loadData() async {
    weightValue.value = double.parse(await Preference().read(Const.prefWeight));
    heightValue.value = double.parse(await Preference().read(Const.prefHeight));
    debugPrint('onNextBmi => weight ${weightValue.value} kg');
    debugPrint('onNextBmi => height ${heightValue.value} cm');
    bmiValue.value = (weightValue.value / ((heightValue.value/100) * (heightValue.value/100))).toPrecision(2);
    debugPrint('onNextBmi => bmiValue.value ${bmiValue.value}');

    if(bmiValue.value <= 18.5){
      keyForMap.value = "Underweight";
    } else if(bmiValue.value > 18.5 && bmiValue.value <= 24.9){
      keyForMap.value = "Normal weight";
    } else if(bmiValue.value > 24.9 && bmiValue.value <= 29.9){
      keyForMap.value = "Overweight";
    } else{
      keyForMap.value = "Obesity";
    }

    int goalIndex = await Preference().readInt(Const.prefGoalIndex);
    debugPrint('getInitiData => goalIndex 1 : ${goalIndex}');
    //0 = Muscle Gain, 1 = Weight Loss, 2 = Fitness, 3 = Wellness
    if(goalIndex == 0){
      goal.value = "Muscle Gain";
    }else if(goalIndex == 1){
      goal.value = "Weight Loss";
    }else if(goalIndex == 2){
      goal.value = "Fitness";
    }else{
      goal.value = "Wellness";
    }

  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    loadData();
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class LoadingScreenLogic extends GetxController {

  RxDouble progressvalue = 0.0.obs;
  //0 = Muscle Gain, 1 = Weight Loss, 2 = Fitness, 3 = Wellness


  onNextLoading() async {
    debugPrint('onNextLoading => progressvalue ${progressvalue.value}');

    //go to next screen
    Get.toNamed(AppRoutes.goalScreen);
  }

  animationProgress(){
    progressvalue.value = 0;
    Timer.periodic(const Duration(milliseconds: 30),(timer)
    {
      if(progressvalue.value<100){
        progressvalue.value++;
      }else{
        timer.cancel();
        onNextLoading();
      }
    });
  }


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    animationProgress();
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

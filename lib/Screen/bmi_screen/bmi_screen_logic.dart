import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class BmiScreenLogic extends GetxController {

  RxDouble bmiValue = 0.00.obs;
  RxString keyForMap = "".obs;
  RxString bmiString = "".obs;


  Map<String, List<String>> taglines = <String, List<String>>{
    "Underweight": ["Build Strength, Reclaim Your Power.","Redefine Your Body, Embrace Your Potential.", "Transform Your Weight, Unleash Your Energy.", "Gaining Health, Unlocking Confidence."],
    "Normal weight": ["Fuel Your Fitness, Ignite Your Success.", "Elevate Your Wellness, Embrace Balance.", "Shape Your Body, Enhance Your Lifestyle.", "Empower Your Journey, Embrace Your Vibrancy."],
    "Overweight": ["Transform Your Shape, Reveal Your Best Self.", "Reclaim Your Fitness, Redefine Your Limits.", "Ignite Your Metabolism, Unleash Your Potential.", "Sculpt Your Body, Rediscover Confidence."],
    "Obesity": ["Reshape Your Future, Embrace a Healthier You.", "Unlock Your Strength, Conquer New Horizons.", "Rewrite Your Story, Empower Your Transformation.", "Break Barriers, Ignite Your Weight Loss Journey."
    ]
  };


  onNextBmi() async {
    debugPrint('onNextBmi => bmiValue ${bmiValue.value}');
    // bmiCalculation();
    //go to next screen
    Get.toNamed(AppRoutes.goalScreen);
  }

  bmiCalculation() async {
    double weight = double.parse(await Preference().read(Const.prefWeight));
    double height = double.parse(await Preference().read(Const.prefHeight));
    debugPrint('onNextBmi => weight ${weight} kg');
    debugPrint('onNextBmi => height ${height} cm');
    bmiValue.value = (weight / ((height/100) * (height/100))).toPrecision(2);
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
    // debugPrint("keyForMap ===> ${keyForMap}");
    // debugPrint("keyForMap 1 ===> ${taglines.containsKey(keyForMap)}");
    // debugPrint("List ===> ${taglines[keyForMap]}");
    //
    // debugPrint("List runtimeType ===> ${taglines[keyForMap].runtimeType}");
    // debugPrint("List length ===> ${taglines[keyForMap]!.toList().length}");
    // debugPrint("int ===> ${Random().nextInt(4)}");
    bmiString.value = taglines[keyForMap.value]![Random().nextInt(4)];
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    bmiCalculation();
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

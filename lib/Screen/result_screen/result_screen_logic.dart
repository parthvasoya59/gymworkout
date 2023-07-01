
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/Screen/calculator_screen/calculator_screen_logic.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class ResultScreenLogic extends GetxController {

  RxDouble totalCal = 0.0.obs, protein = 0.0.obs, fats = 0.0.obs, bmi = 0.0.obs, tdee = 0.0.obs, carbs = 0.0.obs;
  RxString bmiText = "NORMAL".obs;
  RxDouble bmr = 1.0.obs;

  RxBool isMale = true.obs;
  RxInt height = 160.obs;
  RxDouble weight = 45.0.obs;
  RxInt age = 25.obs;
  RxString selectedActivityLevel = "Moderately Active".obs;
  RxString selectedGaol = "Weight Loss".obs;

  loadData(){
    var calCon = Get.find<CalculatorScreenLogic>();
    debugPrint("calCon.isMale --> ${calCon.isMale.value}");
    isMale.value = calCon.isMale.value;
    debugPrint("calCon.height --> ${calCon.height}");
    height.value = calCon.height.value;
    debugPrint("calCon.weight --> ${calCon.weight}");
    weight.value = calCon.weight.value;
    debugPrint("calCon.age --> ${calCon.age}");
    age.value = calCon.age.value;
    debugPrint("calCon.selectedActivityLevel --> ${calCon.selectedActivityLevel}");
    selectedActivityLevel.value = calCon.selectedActivityLevel.value;
    debugPrint("calCon.selectedGaol --> ${calCon.selectedGaol}");
    selectedGaol.value = calCon.selectedGaol.value;
    bmiCalculate();
    bmiTextCalculate();
    bmrCalculate();
    tdeeCalculate();
    totalCaloriesCalculate();
    proteinCalculate();
    fatCalculate();
    carbsCalculated();
  }

  bmiCalculate() {
    bmi.value = (weight.value / pow(height / 100, 2));
  }

  bmiTextCalculate() {
    if (bmi.value < 18.5)
      bmiText.value = 'UNDERWEIGHT';
    else if (bmi.value >= 18.5 && bmi.value <= 24.9)
      bmiText.value = 'NORMAL';
    else if (bmi.value >= 25 && bmi.value <= 29.9)
      bmiText.value = 'OVERWEIGHT';
    else if (bmi.value >= 30 && bmi.value <= 34.9)
      bmiText.value = 'OBESE';
    else if (bmi.value >= 35)
      bmiText.value = 'EXTREMLY OBESE';
    else
      bmiText.value = 'BMI';
  }

  bmrCalculate() {
    if (isMale.value) {
      bmr.value = 10 * weight.value + 6.25 * height.value - 5 * age.value + 5;
    } else {
      bmr.value = 10 * weight.value + 6.25 * height.value - 5 * age.value - 161;
    }
  }

  tdeeCalculate() {
    if (selectedActivityLevel.value == "Sedentary Active")
      tdee.value = bmr.value * 1.2;
    else if (selectedActivityLevel.value == "Lightly Active")
      tdee.value = bmr.value * 1.375;
    else if (selectedActivityLevel.value == "Moderately Active")
      tdee.value = bmr.value * 1.55;
    else if (selectedActivityLevel.value == "Very Active")
      tdee.value = bmr.value * 1.725;
    else if (selectedActivityLevel.value == "Extremely Active")
      tdee.value = bmr.value * 1.9;
    else
      tdee.value = 0;
  }

  totalCaloriesCalculate() {
    if (selectedGaol.value == "Weight Loss") {
      totalCal.value = (tdee.value - 500);
    } else if (selectedGaol.value == "Maintain Weight") {
      totalCal.value = tdee.value;
    } else if (selectedGaol.value == "Muscle Gain") {
      totalCal.value = tdee.value + 400;
    } else
      totalCal.value = 0;
  }

  proteinCalculate() {
    if (selectedGaol.value == "Weight Loss") {
      protein.value = ((1.1 * (weight.value * 2.2)) * 4) / 4;
    } else if (selectedGaol.value == "Maintain Weight") {
      protein.value = ((weight.value * 2.2) * 4) / 4;
    } else if (selectedGaol.value == "Muscle Gain") {
      protein.value = ((0.9 * (weight.value * 2.2)) * 4) / 4;
    } else{
      protein.value = 0;
    }
  }

  fatCalculate() {
    if (selectedGaol.value == "Weight Loss") {
      fats.value = (0.20 * totalCal.value) / 9;
    } else if (selectedGaol.value == "Maintain Weight") {
      fats.value = (0.20 * totalCal.value) / 9;
    } else if (selectedGaol.value == "Muscle Gain") {
      fats.value = (0.25 * totalCal.value) / 9;
    } else{
      fats.value = 0;
    }
  }

  carbsCalculated() {
    if (selectedGaol.value == "Weight Loss") {
      carbs.value = (totalCal.value - (fats.value * 9 + protein.value * 4)) / 4;
    } else if (selectedGaol.value == "Maintain Weight") {
      carbs.value = (totalCal.value - (protein.value * 4 + fats.value * 9)) / 4;
    } else if (selectedGaol.value == "Muscle Gain") {
      carbs.value = (totalCal.value - (fats.value * 9 + protein.value * 4)) / 4;
    } else{
      carbs.value = 0;
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
    if(totalCal.value == 0){
      loadData();
    }
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

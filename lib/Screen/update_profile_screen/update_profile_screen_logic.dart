import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/Screen/dashboard_screen/dashboard_screen_logic.dart';
import 'package:gymworkout/Screen/home_screen/home_screen_logic.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';
import '../profile_screen/profile_screen_logic.dart';


class UpdateProfileScreenLogic extends GetxController {

  RxDouble bmiValue = 0.00.obs, weightValue = 45.0.obs, heightValue = 130.0.obs;
  RxString keyForMap = "".obs, goal = "".obs;

  RxBool isMale = true.obs;
  RxInt goalIndex = 0.obs;
  RxList<String> genderItems = ["Male", "Female"].obs;
  RxList<String> goalItems = ["Muscle Gain", "Weight Loss", "Fitness", "Wellness"].obs;
  RxBool showGenderBorder = false.obs;
  RxBool showGoalBorder = false.obs;
  RxString dropdownGenderValue = "Male".obs;
  RxString dropdownGoalValue = "Muscle Gain".obs;

  TextEditingController cHeight = TextEditingController();
  TextEditingController cWeight = TextEditingController();

  RxDouble changeHeightFt = 0.0.obs;
  RxDouble changeWeightLb = 0.0.obs;

  RxString heightError = "".obs, weightError = "".obs;


  onChangeHeight(){
    debugPrint("onChangeHeight ---> ");
    changeHeightFt.value = cHeight.text != "" ? (double.parse(cHeight.text) / 30.48).toPrecision(2) : 0;
    bmiChangeOnHW();
    heightValidator();
  }

  heightValidator(){
    if(cHeight.text == ""){
      heightError.value = "Invalid height.";
    }else if(!cHeight.text.isNum){
      heightError.value = "Invalid height (numbers only).";
    }else{
      heightError.value = "";
    }
  }

  onChangeWeight(){
    debugPrint("onChangeWeight ---> ");
    changeWeightLb.value = cWeight.text != "" ? (double.parse(cWeight.text) * 2.20462262185).toPrecision(2) : 0;
    bmiChangeOnHW();
    weightValidator();
  }

  weightValidator(){
    if(cWeight.text == ""){
      weightError.value = "Invalid weight.";
    }else if(!cWeight.text.isNum){
      weightError.value = "Invalid weight (numbers only).";
    }else{
      weightError.value = "";
    }
  }

  bmiChangeOnHW(){
    if(cHeight.text != "" && cWeight.text != ""){
      double we = double.parse(cWeight.text);
      double hei = double.parse(cHeight.text);
      bmiValue.value = (we / ((hei/100) * (hei/100))).toPrecision(2);
    }else{
      bmiValue.value = 0.0;
    }
    debugPrint('onNextBmi => bmiValue.value ${bmiValue.value}');
  }

  void onGenderDropDownChanged(RxString val) {
    dropdownGenderValue.value = val.value;
    debugPrint('onGenderDropDownChanged => dropdownGenderValue.value : ${dropdownGenderValue.value}');
  }

  void onGoalDropDownChanged(RxString val) {
    dropdownGoalValue.value = val.value;
    debugPrint('onGoalDropDownChanged => dropdownGoalValue.value : ${dropdownGoalValue.value}');
  }

  void onGenderTypeTap(RxBool val) {
    showGenderBorder.value = val.value;
  }

  void onGoalTypeTap(RxBool val) {
    showGoalBorder.value = val.value;
  }

  loadData() async {

    isMale.value = await Preference().readBool(Const.prefGender) ?? true;
    if(isMale.value){
      onGenderDropDownChanged("Male".obs);
    }else{
      onGenderDropDownChanged("Female".obs);
    }

    weightValue.value = double.parse(await Preference().read(Const.prefWeight));
    heightValue.value = double.parse(await Preference().read(Const.prefHeight));
    cHeight.text = heightValue.value.toString();
    onChangeHeight();
    cWeight.text = weightValue.value.toString();
    onChangeWeight();
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
      dropdownGoalValue.value = "Muscle Gain";
    }else if(goalIndex == 1){
      goal.value = "Weight Loss";
      dropdownGoalValue.value = "Weight Loss";
    }else if(goalIndex == 2){
      goal.value = "Fitness";
      dropdownGoalValue.value = "Fitness";
    }else{
      goal.value = "Wellness";
      dropdownGoalValue.value = "Wellness";
    }
  }



  onSubmit(){
    heightValidator();
    weightValidator();
    if(heightError.value == "" && weightError.value == ""){
      onSubmit1();
    }else{
      Const().toast("Please fill all valid details.");
    }
  }

  onSubmit1() async {
    debugPrint("onSubmit ---> ");
    //gender
    if(dropdownGenderValue.value == "Male"){
      await Preference().saveBool(Const.prefGender, true);
    }else{
      await Preference().saveBool(Const.prefGender, false);
    }

    //height
    await Preference().save(Const.prefHeight, double.parse(cHeight.text).round().toString());

    //weight
    await Preference().save(Const.prefWeight, double.parse(cWeight.text).toString());

    //goal
    //0 = Muscle Gain, 1 = Weight Loss, 2 = Fitness, 3 = Wellness
    if(dropdownGoalValue.value == "Muscle Gain"){
      goalIndex.value = 0;
    }else if(dropdownGoalValue.value == "Weight Loss"){
      goalIndex.value = 1;
    }else if(dropdownGoalValue.value == "Fitness"){
      goalIndex.value = 2;
    }else if(dropdownGoalValue.value == "Wellness"){
      goalIndex.value = 3;
    }else{
      goalIndex.value = 0;
    }
    await Preference().saveInt(Const.prefGoalIndex, goalIndex.value);

    Const().toast("Profile updated successfully!");
    var profileCon = Get.find<ProfileScreenLogic>();
    await profileCon.loadData();
    Get.toNamed(AppRoutes.dashboardScreen);
    var dashboardCon = Get.find<DashboardScreenLogic>();
    dashboardCon.changeTabIndex(2);
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

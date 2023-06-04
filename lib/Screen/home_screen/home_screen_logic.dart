import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/Screen/home_screen/homemodel.dart';

import '../../AppRoute/NavigationArgs.dart';
import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class HomeScreenLogic extends GetxController {

  RxBool isMale = true.obs;
  RxInt goalIndex = 0.obs;
  //0 = Muscle Gain, 1 = Weight Loss, 2 = Fitness, 3 = Wellness

  RxList<HomeModel> homeModelList = <HomeModel>[].obs;

  List<HomeModel> homeModelListMMG = <HomeModel>[
    HomeModel(imageUrl: "https://i.postimg.cc/CLMHPR6d/chesthomem.jpg", txt: "Chest"),
    HomeModel(imageUrl: "https://i.postimg.cc/rsjGyTz8/backhomem.jpg", txt: "Back"),
    HomeModel(imageUrl: "https://i.postimg.cc/JhHQNSYq/shoulderhomem.jpg", txt: "Shoulder"),
    HomeModel(imageUrl: "https://i.postimg.cc/pTNJqkgt/armshomem.jpg", txt: "Arms"),
    HomeModel(imageUrl: "https://i.postimg.cc/T2JJJV0Z/abshomem.jpg", txt: "Abs"),
    HomeModel(imageUrl: "https://i.postimg.cc/RCsmKXCp/legshomem.png", txt: "Legs"),
  ];

  List<HomeModel> homeModelListFMG = <HomeModel>[
    HomeModel(imageUrl: "https://i.postimg.cc/264FJhDL/shoulderhomef.jpg", txt: "Shoulder"),
    HomeModel(imageUrl: "https://i.postimg.cc/kgpct7sG/abshomef.jpg", txt: "Abs"),
    HomeModel(imageUrl: "https://i.postimg.cc/qq4XdqJb/legshomef.jpg", txt: "Legs"),
  ];

  getInitiData() async {
    debugPrint('getInitiData => isMale : ${isMale.value}');

    isMale.value = await Preference().readBool(Const.prefGender);
    debugPrint('getInitiData => isMale 1 : ${isMale.value}');

    //0 = Muscle Gain, 1 = Weight Loss, 2 = Fitness, 3 = Wellness
    goalIndex.value = await Preference().readInt(Const.prefGoalIndex);
    debugPrint('getInitiData => goalIndex 1 : ${goalIndex.value}');

    if(isMale.value == true && goalIndex.value == 0){ // Male + Muscle Gain
      homeModelList.value = homeModelListMMG;
    } else if (isMale.value == false && goalIndex.value == 0){ // Female + Muscle Gain
      homeModelList.value = homeModelListFMG;
    }

  }

  onTapOfHomeTab(String txt){
    String appended = "";
    if(isMale.value == true && goalIndex.value == 0){ // Male + Muscle Gain
      appended = "MMG";
    } else if (isMale.value == false && goalIndex.value == 0){ // Female + Muscle Gain
      appended = "FMG";
    }

    debugPrint('onTapOfHomeTab => excerciseType : ${txt + appended}');

    Get.toNamed(AppRoutes.excerciseScreen, arguments: {
      NavigationArgs.excerciseType: txt + appended
    });

  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getInitiData();
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

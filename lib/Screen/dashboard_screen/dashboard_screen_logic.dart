import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/Screen/gender_sel_screen/gender_sel_screen_logic.dart';
import 'package:gymworkout/Screen/goal_screen/goal_screen_logic.dart';
import 'package:gymworkout/Screen/home_screen/home_screen_logic.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class DashboardScreenLogic extends GetxController {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt tabIndex = 0.obs;


  List<BottomNavigationBarItem> bottomNavigationBarItemsofDriver = [
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.home, color: cBlack,),
      icon: Icon(Icons.home,),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.edit, color: cBlack,),
      icon: Icon(Icons.edit,),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.person, color: cBlack,),
      icon: Icon(Icons.person,),
      label: 'Home',
    ),
  ];

  void changeTabIndex(int index) {
    tabIndex.value = index;

    debugPrint('changeTabIndex tabIndex.value == ${tabIndex.value}');

    if (index == 0) {
      bool home = Get.isRegistered<HomeScreenLogic>();
      debugPrint('index == 0');
      if (home == false) {
        Get.put<HomeScreenLogic>(HomeScreenLogic());
      }
    } else if (index == 1) {
      bool edit = Get.isRegistered<GoalScreenLogic>();
      debugPrint('index == 1');
      if (edit == false) {
        Get.put<GoalScreenLogic>(GoalScreenLogic());
      } else if (index == 2) {
        bool edit = Get.isRegistered<GenderSelScreenLogic>();
        debugPrint('index == 2');
        if (edit == false) {
          Get.put<GenderSelScreenLogic>(GenderSelScreenLogic());
        }
      }
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
}

/*
Underweight = <18.5
Normal weight = 18.5–24.9
Overweight = 25–29.9
Obesity = BMI of 30 or greater
 */

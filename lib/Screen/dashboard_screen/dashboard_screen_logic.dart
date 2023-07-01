import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/Screen/home_screen/home_screen_logic.dart';
import 'package:gymworkout/Screen/profile_screen/profile_screen_logic.dart';

import '../calculator_screen/calculator_screen_logic.dart';



class DashboardScreenLogic extends GetxController {

  // GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt tabIndex = 0.obs;

  List<BottomNavigationBarItem> bottomNavigationBarItemsofDriver = [
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.home, color: cBlack, size: 30,),
      icon: Icon(Icons.home,),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.calculate_rounded, color: cBlack, size: 30,),
      icon: Icon(Icons.calculate_rounded,),
      label: 'Calculator',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.person, color: cBlack, size: 30,),
      icon: Icon(Icons.person,),
      label: 'Profile',
    ),
  ];

  void changeTabIndex(int index) {
    if (index == 0) {
      bool home = Get.isRegistered<HomeScreenLogic>();
      debugPrint('index == 0 home --> ${home}');
      if (home == false) {
        Get.put<HomeScreenLogic>(HomeScreenLogic());
      }
      Get.find<HomeScreenLogic>().onInit();
    } else if (index == 1) {
      bool cal = Get.isRegistered<CalculatorScreenLogic>();
      debugPrint('index == 1 cal --> ${cal}');
      if (cal == false) {
        Get.put<CalculatorScreenLogic>(CalculatorScreenLogic());
      }
    } else if (index == 2) {
      bool pro = Get.isRegistered<ProfileScreenLogic>();
      debugPrint('index == 2 pro --> ${pro}');
      if (pro == false) {
        Get.put<ProfileScreenLogic>(ProfileScreenLogic());
      }
      Get.find<ProfileScreenLogic>().loadData();
    }

    tabIndex.value = index;

    debugPrint('changeTabIndex tabIndex.value == ${tabIndex.value}');

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

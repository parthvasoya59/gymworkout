import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/Screen/excercise_screen/excercise_screen_logic.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/ExcerciseModel.dart';
import '../../Utils/preference.dart';


class ExcerciseDetailScreenLogic extends GetxController {

  Rx<ExcerciseModel>? selectedExcerciseModel;

  loadData(){
    var controllerExc = Get.find<ExcerciseScreenLogic>();
    selectedExcerciseModel = controllerExc.selectedExcerciseModel;
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
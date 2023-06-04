import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/AppRoute/NavigationArgs.dart';

class ExcerciseScreenLogic extends GetxController {

  RxString excerciseType = "".obs, goalType = "".obs, gender = "".obs;

  getInitData() async {
    debugPrint('getInitData => excerciseType : ');
    excerciseType.value = await Get.arguments[NavigationArgs.excerciseType];
    debugPrint('getInitData => excerciseType 1 : ${excerciseType.value}');
    int length = excerciseType.value.length;
    goalType.value = excerciseType.value.substring(length-2);
    gender.value = excerciseType.value.substring(length-3, length-2);
    debugPrint('getInitData => goalType : ${goalType.value}');
    debugPrint('getInitData => gender : ${gender.value}');
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getInitData();
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

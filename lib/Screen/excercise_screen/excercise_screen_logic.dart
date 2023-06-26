import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/AppRoute/NavigationArgs.dart';
import 'package:gymworkout/AppRoute/app_route.dart';
import 'package:gymworkout/Screen/home_screen/home_screen_logic.dart';

import '../../Utils/ExcerciseModel.dart';
import '../home_screen/homemodel.dart';

class ExcerciseScreenLogic extends GetxController {

  RxString excerciseType = "".obs, goalType = "".obs, gender = "".obs, backImage = "".obs;

  RxList<ExcerciseModel> excerciseModelList = <ExcerciseModel>[].obs;

  Rx<ExcerciseModel>? selectedExcerciseModel;

  getInitData() async {
    debugPrint('getInitData => excerciseType : ');
    excerciseType.value = await Get.arguments[NavigationArgs.excerciseType];
    debugPrint('getInitData => excerciseType 1 : ${excerciseType.value}');
    int length = excerciseType.value.length;
    goalType.value = excerciseType.value.substring(length-2);
    gender.value = excerciseType.value.substring(length-3, length-2);
    debugPrint('getInitData => goalType : ${goalType.value}');
    debugPrint('getInitData => gender : ${gender.value}');
    backImage.value = Get.find<HomeScreenLogic>().homeModelListMMG.where((element) => element.txt == excerciseType.value).first.imageUrl;
    loadData();
  }

  loadData() async {
    String urlFile = "assets/data/${excerciseType.value}.json";
    String data = await DefaultAssetBundle.of(Get.context!).loadString(urlFile);
    excerciseModelList.value = excerciseModelFromJson(data);
    debugPrint('loadData => excerciseModelList : ${excerciseModelList.value}');
    debugPrint('loadData => excerciseModelList length : ${excerciseModelList.value.length}');
    final jsonResult = jsonDecode(data);
    selectedExcerciseModel = excerciseModelList.value.first.obs;
    debugPrint('selectedExcerciseModel excericeName =>  ${selectedExcerciseModel!.value.excericeName}');
    // debugPrint('loadData => jsonResult : ${jsonResult}');
  }



  onTapofExcerciseTab(int index){
    debugPrint('onTapofExcerciseTab => ');
    selectedExcerciseModel!.value = excerciseModelList.value[index];
    Get.toNamed(AppRoutes.excerciseDetailScreen);
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

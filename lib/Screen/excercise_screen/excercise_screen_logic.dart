import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/AppRoute/NavigationArgs.dart';

import '../../Utils/ExcerciseModel.dart';
import '../home_screen/homemodel.dart';

class ExcerciseScreenLogic extends GetxController {

  RxString excerciseType = "".obs, goalType = "".obs, gender = "".obs;

  List<HomeModel> excerciseListFMG = <HomeModel>[
    HomeModel(imageUrl: "https://i.postimg.cc/264FJhDL/shoulderhomef.jpg", txt: "Shoulder"),
    HomeModel(imageUrl: "https://i.postimg.cc/kgpct7sG/abshomef.jpg", txt: "Abs"),
    HomeModel(imageUrl: "https://i.postimg.cc/qq4XdqJb/legshomef.jpg", txt: "Legs"),
  ];

  RxList<ExcerciseModel> excerciseModelList = <ExcerciseModel>[].obs;

  getInitData() async {
    debugPrint('getInitData => excerciseType : ');
    excerciseType.value = await Get.arguments[NavigationArgs.excerciseType];
    debugPrint('getInitData => excerciseType 1 : ${excerciseType.value}');
    int length = excerciseType.value.length;
    goalType.value = excerciseType.value.substring(length-2);
    gender.value = excerciseType.value.substring(length-3, length-2);
    debugPrint('getInitData => goalType : ${goalType.value}');
    debugPrint('getInitData => gender : ${gender.value}');
    loadData();
  }

  loadData() async {
    String data = await DefaultAssetBundle.of(Get.context!).loadString("assets/data/ChestMMG.json");
    excerciseModelList.value = excerciseModelFromJson(data);
    debugPrint('loadData => excerciseModelList : ${excerciseModelList.value}');
    debugPrint('loadData => excerciseModelList length : ${excerciseModelList.value.length}');

    final jsonResult = jsonDecode(data);
    // debugPrint('loadData => jsonResult : ${jsonResult}');


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

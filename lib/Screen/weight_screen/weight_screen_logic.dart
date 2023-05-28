import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class WeightScreenLogic extends GetxController {

  RxDouble pointerValue = 45.0.obs;
  RxDouble minimumLevel = 0.0.obs;
  RxDouble maximumLevel = 2000.0.obs;

  onNextWeightSelection() async {
    debugPrint('onNextWeightSelection => pointerValue ${pointerValue.value.toString()}');

    await Preference().save(Const.prefWeight, pointerValue.value.toString());

    //go to next screen
    Get.toNamed(AppRoutes.bmiScreen);
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

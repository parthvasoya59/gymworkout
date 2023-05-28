import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppRoute/app_route.dart';
import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';


class HeightScreenLogic extends GetxController {

  RxDouble pointerValue = 130.0.obs;
  RxDouble minimumLevel = 0.0.obs;
  RxDouble maximumLevel = 200.0.obs;

  onNextHightSelection() async {
    debugPrint('onNextHightSelection => pointerValue ${pointerValue.value.round().toString()}');

    await Preference().save(Const.prefHeight, pointerValue.value.round().toString());

    //go to next screen
    Get.toNamed(AppRoutes.weightScreen);
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

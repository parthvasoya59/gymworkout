import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/app_constant.dart';


class HeightScreenLogic extends GetxController {

  RxDouble pointerValue = 130.0.obs;
  RxDouble minimumLevel = 0.0.obs;
  RxDouble maximumLevel = 200.0.obs;

  onNextHightSelection() async {
    debugPrint('onNextHightSelection => pointerValue ${pointerValue.value}');
    // await Preference().saveBool(Const.prefGender, isMale.value);
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

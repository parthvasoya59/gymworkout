import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/AppRoute/app_route.dart';

import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';

class GenderSelScreenLogic extends GetxController {

  RxBool isMale = true.obs;

  onClickofMale(){
    debugPrint('onClickofMale => isMale : ${isMale.value}');
    isMale.value = true;
  }

  onClickofFemale(){
    debugPrint('onClickofFemale => isMale : ${isMale.value}');
    isMale.value = false;
  }

  onNextGenderSelection() async {
    debugPrint('onNextGenderSelection => isMale : ${isMale.value}');
    await Preference().saveBool(Const.prefGender, isMale.value);
    Get.toNamed(AppRoutes.areaScreen);
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constant/app_constant.dart';
import '../../Utils/preference.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';


class AreaScreenLogic extends GetxController {

  MultiSelectController multiSelectController = MultiSelectController();

  List<MultiSelectCard<String>> bodyArea = [
    MultiSelectCard(value: BodyArea.fullBody, label: BodyArea.fullBody, selected: true),
    MultiSelectCard(value: BodyArea.shoulder, label: BodyArea.shoulder, ),
    MultiSelectCard(value: BodyArea.back, label: BodyArea.back),
    MultiSelectCard(value: BodyArea.chest, label: BodyArea.chest),
    MultiSelectCard(value: BodyArea.abs, label: BodyArea.abs),
    MultiSelectCard(value: BodyArea.leg, label: BodyArea.leg),
    MultiSelectCard(value: BodyArea.arms, label: BodyArea.arms),
    MultiSelectCard(value: BodyArea.butt, label: BodyArea.butt),
  ];

  onNextBodyAreaSelection() async {
    debugPrint('onNextBodyAreaSelection => ');
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

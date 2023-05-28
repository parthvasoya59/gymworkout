import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymworkout/AppRoute/app_route.dart';

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
    List<dynamic> sellist = multiSelectController.getSelectedItems();
    // first get all selected item in list, convert to set so remove duplicate, convert to string and remove parenthesis
    String dummy = sellist.toSet().toString();
    String selectedString = dummy.substring(1, dummy.length-1);
    debugPrint('getSelectedItems ==> ${selectedString}');
    await Preference().save(Const.prefSelectedArea, selectedString);
    // String readSel = await Preference().read(Const.prefSelectedArea);
    // debugPrint('readSel ==> ${readSel}');

    //go to next screen
    Get.toNamed(AppRoutes.heightScreen);
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

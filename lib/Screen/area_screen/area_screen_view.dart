import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';


import '../../widget/custom_button.dart';
import '../../widget/progress_bar.dart';
import 'area_screen_logic.dart';

class AreaScreenWidget extends GetView<AreaScreenLogic> {
  const AreaScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<AreaScreenLogic>();
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: cBlack,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(w * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Select the areas you want to focus on",
                textAlign: TextAlign.center,
                style: AppStyle.textStyleLatoBoldWhite30,
              ),
              MultiSelectContainer(
                items: controller.bodyArea,
                controller: controller.multiSelectController,
                onChange: (allSelectedItems, selectedItem) {},
                wrapSettings: WrapSettings(
                  spacing: 20,
                  runSpacing: 20
                ),
                itemsPadding: EdgeInsets.symmetric(vertical: w * 0.02, horizontal: w * 0.03),
                textStyles: MultiSelectTextStyles(
                  selectedTextStyle: AppStyle.textStyleLatoBoldBlack20,
                  disabledTextStyle: AppStyle.textStyleLatoBoldBlack20
                ),
                itemsDecoration: MultiSelectDecorations(
                  decoration: BoxDecoration(
                    color: cGreyDisable,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  selectedDecoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(5),
                  )
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Progressbar(valueIn: 14.28*2),
                  SizedBox(height: h * 0.03,),
                  CustomButton(
                    title: "Next",
                    backgroundColor: cWhite,
                    textStyle: AppStyle.textStyleLatoMediumBlack20,
                    onPressed: controller.onNextBodyAreaSelection,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

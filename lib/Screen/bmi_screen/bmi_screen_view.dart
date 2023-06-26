import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/custom_button.dart';
import '../../widget/progress_bar.dart';
import 'bmi_screen_logic.dart';

class BmiScreenWidget extends GetView<BmiScreenLogic> {
  const BmiScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BmiScreenLogic>();
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
                "Your Current BMI",
                textAlign: TextAlign.center,
                style: AppStyle.textStyleLatoBoldWhite30,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    return Text(
                      controller.bmiValue.value.toString(),
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldWhite60,
                    );
                  }),
                  SizedBox(height: h * 0.03,),
                  Obx(() {
                    return Text(
                      controller.keyForMap.value,
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldGrey20.copyWith(fontWeight: FontWeight.bold),
                    );
                  }),
                  SizedBox(height: h * 0.03,),
                  Obx(() {
                    return Text(
                      controller.bmiString.value,
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoMediumGrey20,
                    );
                  }),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Progressbar(valueIn: 14.28 * 2),
                  SizedBox(height: h * 0.03,),
                  CustomButton(
                    title: "Next",
                    backgroundColor: cWhite,
                    textStyle: AppStyle.textStyleLatoMediumBlack20,
                    onPressed: controller.onNextBmi,
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


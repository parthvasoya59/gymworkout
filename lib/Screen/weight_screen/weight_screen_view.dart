import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/app_image.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../widget/custom_button.dart';
import '../../widget/progress_bar.dart';
import 'weight_screen_logic.dart';

class WeightScreenWidget extends GetView<WeightScreenLogic> {
  const WeightScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<WeightScreenLogic>();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "What's your weight?",
              textAlign: TextAlign.center,
              style: AppStyle.textStyleLatoBoldWhite30,
            ),
            Center(
              child: Column(
                children: [
                  Obx(() {
                    return Text(
                      controller.pointerValue.value.toString() + " kg = " +
                          (controller.pointerValue.value * 2.20462262185).toPrecision(2).toString() + " lb",
                      style: AppStyle.textStyleLatoBoldWhite25,
                    );
                  }),
                  SizedBox(height: h * 0.03,),
                  Container(
                    width: w,
                    height: h * 0.1,
                    child: Obx(() {
                      return WheelSlider(
                        totalCount: controller.maximumLevel.value.toInt(),
                        initValue: 45,
                        isInfinite: false,
                        onValueChanged: (val) {
                          controller.pointerValue.value = val/10;
                          // debugPrint("WheelSlider --> onValueChanged  ${val}");
                        },
                        pointerColor: cWhite,
                        showPointer: true,
                        lineColor: cWhite,
                        pointerHeight: h * 0.1,
                      );
                    }),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Progressbar(valueIn: 100 / 6 * 4),
                SizedBox(height: h * 0.03,),
                CustomButton(
                  title: "Next",
                  backgroundColor: cWhite,
                  textStyle: AppStyle.textStyleLatoMediumBlack20,
                  onPressed: controller.onNextWeightSelection,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


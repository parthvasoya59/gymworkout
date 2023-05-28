import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/app_image.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


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
            Obx(() {
              return Text(
                controller.pointerValue.value.round().toString() + " cm = " +
                    (controller.pointerValue.value / 30.48).toPrecision(2).toString() + " ft",
                style: AppStyle.textStyleLatoBoldWhite25,
              );
            }),
            Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      height: h * 0.4,
                      width: w * 3,
                      color: Colors.cyan,
                      padding: const EdgeInsets.all(5.0),
                      child: Obx(() {
                        return SfLinearGauge(
                          orientation: LinearGaugeOrientation.horizontal,
                          animateAxis: true,
                          axisTrackExtent: 1,
                          maximum: controller.maximumLevel.value,
                          tickPosition: LinearElementPosition.outside,
                          labelPosition: LinearLabelPosition.outside,
                          minorTicksPerInterval: 10,
                          interval: 10,
                          axisLabelStyle: AppStyle.textStyleLatoMediumWhite15,
                          showTicks: true,
                          showLabels: true,

                          majorTickStyle: LinearTickStyle(
                            color: cWhite,
                            length: h * 0.08
                          ),
                          minorTickStyle: LinearTickStyle(
                            color: cWhite,
                            length: h * 0.035
                          ),
                          axisTrackStyle: LinearAxisTrackStyle(
                            color: cWhite,
                          ),
                          animateRange: true,
                          markerPointers: <LinearMarkerPointer>[
                            LinearShapePointer(
                                value: controller.pointerValue.value,
                                enableAnimation: false,
                                onChanged: (dynamic value) {
                                  controller.pointerValue.value = value;
                                },
                                shapeType: LinearShapePointerType.rectangle,
                                color: cBlack,
                                height: 1,
                                width: 1),
                            LinearWidgetPointer(
                                value: controller.pointerValue.value,
                                enableAnimation: true,
                                onChanged: (dynamic value) {
                                  controller.pointerValue.value = value;
                                },
                                position: LinearElementPosition.outside,
                                child: Container(
                                    width: 2,
                                    height: h * 0.16,
                                  color: cWhite,
                                ),
                            ),
                            LinearWidgetPointer(
                                value: controller.pointerValue.value,
                                enableAnimation: true,
                                onChanged: (dynamic value) {
                                  controller.pointerValue.value = value;
                                },
                                dragBehavior: LinearMarkerDragBehavior.constrained,
                                offset: h * 0.16,
                                position: LinearElementPosition.outside,
                                child: Container(
                                    width: w * 0.3,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: cWhite,
                                        borderRadius: BorderRadius.circular(
                                            4)),
                                    child: Center(
                                      child: Text(
                                        controller.pointerValue.toStringAsFixed(
                                            2) +
                                            ' KG',
                                        style: AppStyle
                                            .textStyleLatoBoldBlack20,
                                      ),
                                    ))),
                          ],
                        );
                      })),
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Progressbar(valueIn: 14.28 * 2),
                SizedBox(height: h * 0.03,),
                CustomButton(
                  title: "Next",
                  backgroundColor: cWhite,
                  textStyle: AppStyle.textStyleLatoMediumBlack20,
                  onPressed: controller.onNextHightSelection,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/app_image.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


import '../../widget/custom_button.dart';
import '../../widget/progress_bar.dart';
import 'height_screen_logic.dart';

class HeightScreenWidget extends GetView<HeightScreenLogic> {
  const HeightScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<HeightScreenLogic>();
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
                "What's your height?",
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
                  child: Container(
                      height: h * 0.5,
                      padding: const EdgeInsets.all(5.0),
                      child: Obx(() {
                        return SfLinearGauge(
                          orientation: LinearGaugeOrientation.vertical,
                          maximum: controller.maximumLevel.value,
                          tickPosition: LinearElementPosition.outside,
                          labelPosition: LinearLabelPosition.outside,
                          minorTicksPerInterval: 10,
                          interval: 25,
                          axisLabelStyle: AppStyle.textStyleLatoMediumWhite15,
                          showTicks: true,
                          showLabels: true,
                          majorTickStyle: LinearTickStyle(
                            color: cWhite,
                          ),
                          minorTickStyle: LinearTickStyle(
                              color: cWhite
                          ),
                          onGenerateLabels: () {
                            return <LinearAxisLabel>[
                              const LinearAxisLabel(text: '0 cm', value: 0,),
                              const LinearAxisLabel(
                                  text: '25 cm', value: 25),
                              const LinearAxisLabel(
                                  text: '50 cm', value: 50),
                              const LinearAxisLabel(
                                  text: '75 cm', value: 75),
                              const LinearAxisLabel(
                                  text: '100 cm', value: 100),
                              const LinearAxisLabel(
                                  text: '125 cm', value: 125),
                              const LinearAxisLabel(
                                  text: '150 cm', value: 150),
                              const LinearAxisLabel(
                                  text: '175 cm', value: 175),
                              const LinearAxisLabel(
                                  text: '200 cm', value: 200),
                            ];
                          },
                          axisTrackStyle: LinearAxisTrackStyle(
                            color: cWhite,
                          ),
                          markerPointers: <LinearMarkerPointer>[
                            LinearShapePointer(
                                value: controller.pointerValue.value,
                                enableAnimation: false,
                                onChanged: (dynamic value) {
                                  controller.pointerValue.value = value;
                                },
                                shapeType: LinearShapePointerType.rectangle,
                                color: cWhite,
                                height: 1.5,
                                width: w * 0.6),
                            LinearWidgetPointer(
                                value: controller.pointerValue.value,
                                enableAnimation: true,
                                onChanged: (dynamic value) {
                                  controller.pointerValue.value = value;
                                },
                                offset: w * 0.45,
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
                                            0) +
                                            ' cm',
                                        style: AppStyle
                                            .textStyleLatoBoldBlack20,
                                      ),
                                    ))),
                          ],
                          ranges: <LinearGaugeRange>[
                            LinearGaugeRange(
                              endValue: controller.pointerValue.value,
                              startWidth: 200,
                              midWidth: 300,
                              endWidth: 200,
                              color: Colors.transparent,
                              child: Image.asset(
                                Assets.menheight,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ],
                        );
                      }))),
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
      ),
    );
  }
}

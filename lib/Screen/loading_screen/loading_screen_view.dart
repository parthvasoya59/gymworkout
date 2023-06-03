import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loading_screen_logic.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LoadingScreenWidget extends GetView<LoadingScreenLogic> {
  const LoadingScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<LoadingScreenLogic>();
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
              Column(
                children: [
                  Text(
                    "Crafting Your Fitness Blueprint, Your Personal Coach Awaits!",
                    textAlign: TextAlign.center,
                    style: AppStyle.textStyleLatoBoldWhite30,
                  ),

                  GestureDetector(
                    onTap: () {
                      controller.animationProgress();
                    },
                    child: Obx(() {
                      return SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            showLabels: false,
                            showTicks: false,
                            startAngle: 270,
                            endAngle: 270,
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: controller.progressvalue.value,
                                width: 0.15,
                                color: Colors.white,
                                pointerOffset: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                enableAnimation: true,
                                animationType: AnimationType.ease,
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Text(
                                  controller.progressvalue.value.round().toString() + "%",
                                  style: AppStyle.textStyleLatoBoldWhite30,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    }),
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


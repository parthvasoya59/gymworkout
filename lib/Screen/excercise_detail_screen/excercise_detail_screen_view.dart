import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'excercise_detail_screen_logic.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ExcerciseDetailScreenWidget extends GetView<ExcerciseDetailScreenLogic> {
  const ExcerciseDetailScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ExcerciseDetailScreenLogic>();
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
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(w * 0.05),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "ExcerciseDetail Screen!",
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldWhite30,
                    ),
                    Text(
                      controller.selectedExcerciseModel != null ? controller.selectedExcerciseModel!.value.excericeName : "",
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldWhite20,
                    ),
                    Text(
                      controller.selectedExcerciseModel != null ? controller.selectedExcerciseModel!.value.videoLink : "",
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldWhite20,
                    ),
                    Text(
                      controller.selectedExcerciseModel != null ? controller.selectedExcerciseModel!.value.description : "",
                      textAlign: TextAlign.justify,
                      style: AppStyle.textStyleLatoBoldWhite20,
                    ),
                    Text(
                      controller.selectedExcerciseModel != null ? controller.selectedExcerciseModel!.value.equipment : "",
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldWhite20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'excercise_screen_logic.dart';

class ExcerciseScreenWidget extends GetView<ExcerciseScreenLogic> {
  const ExcerciseScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ExcerciseScreenLogic>();
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Obx(() {
      debugPrint('getInitData => goalType : ${controller.goalType.value}');
      return Scaffold(
        backgroundColor: cBlack,
        appBar: AppBar(
          title: Text(
            controller.excerciseType.value,
            style: AppStyle.textStyleLatoBoldBlack25,
          ),
          centerTitle: true,
          backgroundColor: cWhite,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
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
                      "Excercise Screen",
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldWhite30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}


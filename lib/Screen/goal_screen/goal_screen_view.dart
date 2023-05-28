import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/custom_button.dart';
import '../../widget/progress_bar.dart';
import 'goal_screen_logic.dart';

class GoalScreenWidget extends GetView<GoalScreenLogic> {
  const GoalScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<GoalScreenLogic>();
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
                    "What's your goal?",
                    textAlign: TextAlign.center,
                    style: AppStyle.textStyleLatoBoldWhite30,
                  ),
                  SizedBox(height: h * 0.03,),
                  Text(
                    "Set Your Goals, Unleash Your Potential.",
                    textAlign: TextAlign.center,
                    style: AppStyle.textStyleLatoBoldGrey20,
                  ),
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


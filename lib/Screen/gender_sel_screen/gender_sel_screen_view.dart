import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/widget/custom_button.dart';

import '../../Constant/app_image.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/progress_bar.dart';
import 'gender_sel_screen_logic.dart';

class GenderSelScreenWidget extends GetView<GenderSelScreenLogic> {
  const GenderSelScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<GenderSelScreenLogic>();
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
                "What's your gender?",
                textAlign: TextAlign.center,
                style: AppStyle.textStyleLatoBoldWhite30,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: controller.onClickofMale,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Container(
                            width: w * 0.35,
                            height: w * 0.35 * 1.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: controller.isMale.value == true
                                      ? cWhite
                                      : Colors.transparent,
                                  width: controller.isMale.value == true
                                      ? 4 : 0),
                              image: DecorationImage(
                                image: AssetImage(Assets.malegenderselecction),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: h * 0.03,),
                        Obx(() {
                          return Text(
                            "Male",
                            textAlign: TextAlign.center,
                            style: controller.isMale.value == true
                                ? AppStyle.textStyleLatoBoldWhite30 : AppStyle
                                .textStyleLatoMediumWhite25,
                          );
                        }),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.onClickofFemale,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Container(
                            width: w * 0.35,
                            height: w * 0.35 * 1.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: controller.isMale.value == false
                                      ? cWhite
                                      : Colors.transparent,
                                  width: controller.isMale.value == false
                                      ? 4 : 0),
                              image: DecorationImage(
                                  image: AssetImage(
                                      Assets.femalegenderselecction),
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: h * 0.03,),
                        Obx(() {
                          return Text(
                            "Female",
                            textAlign: TextAlign.center,
                            style: controller.isMale.value == false
                                ? AppStyle.textStyleLatoBoldWhite30 : AppStyle
                                .textStyleLatoMediumWhite25,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Progressbar(valueIn: 14.28),
                  SizedBox(height: h * 0.03,),
                  CustomButton(
                    title: "Next",
                    backgroundColor: cWhite,
                    textStyle: AppStyle.textStyleLatoMediumBlack20,
                    onPressed: controller.onNextGenderSelection,
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

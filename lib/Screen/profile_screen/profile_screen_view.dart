import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/app_image.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/custom_button.dart';
import 'profile_screen_logic.dart';

class ProfileScreenWidget extends GetView<ProfileScreenLogic> {
  const ProfileScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ProfileScreenLogic>();
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(w * 0.10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: h * 0.05,),
                Column(
                  children: [
                    Container(
                      width: w * 0.35,
                      height: w * 0.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                Assets.hometoplogo,
                              ),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.contain
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.05,),
                Column(
                  children: [
                    Obx(() {
                      return profileTab(
                          "Gender ", controller.isMale.value == true
                          ? "Male"
                          : "Female", w);
                    }),
                    customeSizedBox(h),
                    Obx(() {
                      return profileTab(
                          "Height ", controller.heightValue.value.round().toString() + " cm = " +
                          (controller.heightValue.value / 30.48).toPrecision(2).toString() + " ft", w);
                    }),
                    customeSizedBox(h),
                    Obx(() {
                      return profileTab(
                          "Weight ", controller.weightValue.value.toString() + " kg = " +
                          (controller.weightValue.value * 2.20462262185).toPrecision(2).toString() + " lb", w);
                    }),
                    customeSizedBox(h),
                    Obx(() {
                      return profileTab(
                          "BMI  ", controller.bmiValue.value.toString(), w);
                    }),
                    customeSizedBox(h),
                    Obx(() {
                      return profileTab(
                          "Category  ", controller.keyForMap.value.toString(), w);
                    }),
                    customeSizedBox(h),
                    Obx(() {
                      return profileTab(
                          "Goal  ", controller.goal.value.toString(), w);
                    }),
                    customeSizedBox(h),
                    customeSizedBox(h),
                    CustomButton(
                      title: "Edit Profile",
                      backgroundColor: cWhite,
                      textStyle: AppStyle.textStyleLatoBoldBlack18,
                      onPressed: controller.onUpdateProfile,
                    ),
                    customeSizedBox(h),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox customeSizedBox(double h){
    return SizedBox(height: h * 0.02,);
  }

  Row profileTab(String text1, String text2, w) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
              text1,
              style: AppStyle.textStyleLatoMediumWhite20
          ),
        ),
        Text(
            ":",
            style: AppStyle.textStyleLatoMediumWhite20
        ),
        SizedBox(width: w * 0.01,),
        Expanded(
          flex: 4,
          child: Text(
              text2,
              style: AppStyle.textStyleLatoMediumWhite20
          ),
        ),
      ],
    );
  }

}


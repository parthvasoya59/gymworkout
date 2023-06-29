import 'package:flutter/services.dart';
import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/widget/customDropDown/custom_dropdown_button2.dart';
import 'package:gymworkout/widget/customDropDown/dropdown_button2.dart';
import '../../Constant/app_image.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/text_input_filed.dart';
import 'update_profile_screen_logic.dart';

class UpdateProfileScreenWidget extends GetView<UpdateProfileScreenLogic> {
  const UpdateProfileScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<UpdateProfileScreenLogic>();
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
      appBar: AppBar(
        title: Text(
            "Edit Profile",
            style: AppStyle.textStyleLatoBoldWhite20
        ),
        centerTitle: true,
        backgroundColor: cBlack,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(w * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender', style: AppStyle.textStyleLatoBoldWhite18),
                    customeSizedBox(h),
                    Obx(() {
                      return CustomDropDownWidget(
                        hintText: "Select Gender",
                        items: controller.genderItems,
                        showBorder: controller.showGenderBorder.value,
                        selectedValue: controller.dropdownGenderValue.value,
                        onTap: () {
                          controller.onGenderTypeTap(RxBool(true));
                        },
                        onChanged: (value) {
                          debugPrint(
                              'CustomDropDownWidget => value 1 : $value');
                          try {
                            controller.onGenderDropDownChanged(
                                RxString(value.toString()));
                            debugPrint(
                                'CustomDropDownWidget => value 2 : $value');
                          }
                          catch (e) {
                            debugPrint('CustomDropDownWidget => ERROR : $e');
                          }
                          controller.onGenderTypeTap(RxBool(false));
                        },
                      );
                    }),
                    customeSizedBox(h), customeSizedBox(h),
                    Text('Height', style: AppStyle.textStyleLatoBoldWhite18),
                    customeSizedBox(h),
                    Row(
                      children: [
                        Container(
                          width: w * 0.4,
                          child: TextInputFindOut(
                            controller: controller.cHeight,
                            style: AppStyle.textStyleLatoMediumBlack15,
                            textInputType: TextInputType.number,
                            onChange: (val) {
                              controller.onChangeHeight();
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),)
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Obx(() {
                          return Text(
                              'cm = ' +
                                  controller.changeHeightFt.value
                                      .toString() + " ft".toString(),
                              style: AppStyle.textStyleLatoMediumWhite20);
                        }),
                      ],
                    ),
                    controller.heightError.value != ""
                        ? customeSizedBox(h)
                        : SizedBox(),
                    Obx(() {
                      return controller.heightError.value != "" ? Text(controller.heightError.value,
                        style: AppStyle.textStyleLatoMediumRed15) : SizedBox();
                    }) ,
                    customeSizedBox(h), customeSizedBox(h),
                    Text('Weight', style: AppStyle.textStyleLatoBoldWhite18),
                    customeSizedBox(h),
                    Row(
                      children: [
                        Container(
                          width: w * 0.4,
                          child: TextInputFindOut(
                            controller: controller.cWeight,
                            style: AppStyle.textStyleLatoMediumBlack15,
                            textInputType: TextInputType.number,
                            onChange: (val) {
                              controller.onChangeWeight();
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]'),)
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Obx(() {
                          return Text(
                              'kg = ' +
                                  controller.changeWeightLb.value
                                      .toString() + " lb".toString(),
                              style: AppStyle.textStyleLatoMediumWhite20);
                        }),
                      ],
                    ),
                    controller.weightError.value != ""
                        ? customeSizedBox(h)
                        : SizedBox(),
                    Obx(() {
                      return controller.weightError.value != "" ? Text(controller.weightError.value,
                        style: AppStyle.textStyleLatoMediumRed15) : SizedBox();
                    }) ,
                    customeSizedBox(h), customeSizedBox(h),
                    customeSizedBox(h), customeSizedBox(h),
                    Center(
                        child: Obx(() {
                          return Text(
                              'BMI = ${controller.bmiValue.value}',
                              style: AppStyle.textStyleLatoMediumWhite20);
                        })),
                    customeSizedBox(h), customeSizedBox(h),
                    Text('Goal', style: AppStyle.textStyleLatoBoldWhite18),
                    customeSizedBox(h),
                    Obx(() {
                      return CustomDropDownWidget(
                        hintText: "Select Goal",
                        items: controller.goalItems,
                        showBorder: controller.showGoalBorder.value,
                        selectedValue: controller.dropdownGoalValue.value,
                        onTap: () {
                          controller.onGoalTypeTap(RxBool(true));
                        },
                        onChanged: (value) {
                          debugPrint(
                              'CustomDropDownWidget => value 1 : $value');
                          try {
                            controller.onGoalDropDownChanged(
                                RxString(value.toString()));
                            debugPrint(
                                'CustomDropDownWidget => value 2 : $value');
                          }
                          catch (e) {
                            debugPrint('CustomDropDownWidget => ERROR : $e');
                          }
                          controller.onGoalTypeTap(RxBool(false));
                        },
                      );
                    }),
                    customeSizedBox(h),
                    customeSizedBox(h),
                    customeSizedBox(h),
                    customeSizedBox(h),
                    CustomButton(
                      title: "Submit",
                      backgroundColor: cWhite,
                      textStyle: AppStyle.textStyleLatoBoldBlack18,
                      onPressed: controller.onSubmit,
                    ),
                    SizedBox(height: h * 0.3,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox customeSizedBox(double h) {
    return SizedBox(height: h * 0.01,);
  }

}


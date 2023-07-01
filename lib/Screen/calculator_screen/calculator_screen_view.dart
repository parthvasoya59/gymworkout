import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/widget/customDropDown/custom_dropdown_button2.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../widget/custom_button.dart';
import 'calculator_screen_logic.dart';

class CalculatorScreenWidget extends GetView<CalculatorScreenLogic> {
  const CalculatorScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<CalculatorScreenLogic>();
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
            "Calculator",
            style: AppStyle.textStyleLatoBoldWhite20
        ),
        centerTitle: true,
        backgroundColor: cBlack,
      ),
      floatingActionButton: GestureDetector(
        onTap: controller.onCalculate,
        child: Container(
          width: w * 0.4,
            padding: EdgeInsets.symmetric(horizontal: w * 0.01, vertical: h * 0.015),
            decoration: BoxDecoration(
              color: cBlack,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: cWhite)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check, color: cWhite, size: getFontSize(25),),
                SizedBox(width: w * 0.02,),
                Text("Calculate", style: AppStyle.textStyleLatoMediumWhite20,)
              ],
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: w,
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.03, vertical: w * 0.03),
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                                onTap: controller.onClickMale,
                                child: Obx(() {
                                  return GenderTabCal(
                                      isSelected: controller.isMale.value,
                                      iconData: Icons.male_rounded,
                                      text: "Male");
                                })),
                          ),
                          SizedBox(width: w * 0.03,),
                          Expanded(
                            child: GestureDetector(
                                onTap: controller.onClickFemale,
                                child: Obx(() {
                                  return GenderTabCal(
                                      isSelected: !controller.isMale.value,
                                      iconData: Icons.female_rounded,
                                      text: "Female");
                                })),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  Height",
                            style: AppStyle.textStyleLatoBoldBlack20,),
                          Obx(() {
                            return Text(
                              controller.height.value.toString() + " cm  ",
                              style: AppStyle.textStyleLatoBoldBlack20,);
                          }),
                        ],
                      ),
                      Obx(() {
                        return Slider(
                          value: controller.height.value.toDouble(),
                          onChanged: (val) {
                            controller.height.value = val.toInt();
                          },
                          min: 1,
                          max: 250,
                          activeColor: cBlack,
                          inactiveColor: cGreyBack,
                        );
                      }),
                      SizedBox(
                        height: h * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  Weight",
                            style: AppStyle.textStyleLatoBoldBlack20,),
                          Obx(() {
                            return Text(
                              controller.weight.value.toPrecision(2)
                                  .toString() +
                                  " kg  ",
                              style: AppStyle.textStyleLatoBoldBlack20,);
                          }),
                        ],
                      ),
                      Obx(() {
                        return Slider(
                          value: controller.weight.value,
                          onChanged: (val) {
                            controller.weight.value = val;
                          },
                          min: 1,
                          max: 200,
                          activeColor: cBlack,
                          inactiveColor: cGreyBack,
                        );
                      }),
                      SizedBox(height: h * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  Age",
                            style: AppStyle.textStyleLatoBoldBlack20,),
                          Obx(() {
                            return Text(
                              controller.age.value.toString() + " Years  ",
                              style: AppStyle.textStyleLatoBoldBlack20,);
                          }),
                        ],
                      ),
                      Obx(() {
                        return WheelSlider.number(
                          perspective: 0.002,
                          totalCount: 150,
                          initValue: 25,
                          selectedNumberStyle: AppStyle
                              .textStyleLatoBoldBlack20,
                          unSelectedNumberStyle: AppStyle
                              .textStyleLatoMediumGrey15,
                          currentIndex: controller.age.value,
                          onValueChanged: (val) {
                            controller.age.value = val;
                          },
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.03,),
                Container(
                  width: w,
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.03, vertical: w * 0.03),
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  Activity Level", style: AppStyle
                              .textStyleLatoBoldBlack20,),
                        ],
                      ),
                      SizedBox(height: h * 0.02,),
                      Container(
                        width: w * 0.5,
                        child: Obx(() {
                          return CustomDropdownButton2(
                            hint: "hint",
                            value: controller.selectedActivityLevel.value,
                            dropdownItems: controller.activityLevelList,
                            onChanged: (val) {
                              controller.selectedActivityLevel.value =
                                  val ?? "Moderately Active";
                            },
                            itemWidth: w * 0.5,
                          );
                        }),
                      ),
                      SizedBox(height: h * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  Goal", style: AppStyle
                              .textStyleLatoBoldBlack20,),
                        ],
                      ),
                      SizedBox(height: h * 0.02,),
                      Container(
                        width: w * 0.5,
                        child: Obx(() {
                          return CustomDropdownButton2(
                            hint: "Select Goal",
                            value: controller.selectedGaol.value,
                            dropdownItems: controller.goalList,
                            onChanged: (val) {
                              controller.selectedGaol.value =
                                  val ?? "Weight Loss";
                            },
                            itemWidth: w * 0.5,
                          );
                        }),
                      ),
                      SizedBox(height: h * 0.03,),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.015,),
                CustomButton(
                  title: "Calculate",
                  backgroundColor: cWhite,
                  textStyle: AppStyle.textStyleLatoBoldBlack18,
                  onPressed: controller.onCalculate,
                ),
                SizedBox(height: h * 0.3,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderTabCal extends StatelessWidget {
  GenderTabCal(
      {Key? key, required this.isSelected, required this.iconData, required this.text})
      : super(key: key);

  final bool isSelected;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    var h = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.01, vertical: h * 0.02),
        decoration: BoxDecoration(
          color: isSelected ? cBlack : cGreyBack,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: cWhite, size: getFontSize(25),),
            SizedBox(width: w * 0.02,),
            Text(text, style: AppStyle.textStyleLatoMediumWhite20,)
          ],
        )
    );
  }
}





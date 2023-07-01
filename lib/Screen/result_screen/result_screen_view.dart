import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/Screen/result_screen/result_screen_logic.dart';
import 'package:gymworkout/widget/customDropDown/custom_dropdown_button2.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../widget/custom_button.dart';

class ResultScreenWidget extends GetView<ResultScreenLogic> {
  const ResultScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ResultScreenLogic>();
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
            "Result",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResultTab(
                  w: w,
                  number: controller.totalCal.value.toPrecision(1).toString(),
                  unit: "KCALS",
                  text: "Total Calories",
                ),
                cSizedBox(h),
                ResultTab(
                  w: w,
                  number: controller.carbs.value.toPrecision(1).toString(),
                  unit: "GRAMS",
                  text: "Carbs",
                ),
                cSizedBox(h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResultTab1(
                      number: controller.protein.value.toPrecision(1).toString(),
                      unit: "GRAMS",
                      text: "Protein",
                    ),
                    SizedBox(width: h * 0.02,),
                    ResultTab1(
                      number: controller.fats.value.toPrecision(1).toString(),
                      unit: "GRAMS",
                      text: "Fats",
                    ),
                  ],
                ),
                cSizedBox(h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResultTab1(
                      number: controller.bmi.value.toPrecision(1).toString(),
                      unit: controller.bmiText.value,
                      text: "BMI",
                    ),
                    SizedBox(width: h * 0.02,),
                    ResultTab1(
                      number: controller.tdee.value.toPrecision(1).toString(),
                      unit: "KCALS",
                      text: "TDEE",
                    ),
                  ],
                ),
                SizedBox(height: h * 0.3,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cSizedBox(h){
    return SizedBox(height: h * 0.02,);
  }
}

class ResultTab extends StatelessWidget {
  ResultTab({Key? key, required this.w, required this.number, required this.unit, required this.text}) : super(key: key);

  final double w;
  final String number, unit, text;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      width: w,
      padding: EdgeInsets.symmetric(
          horizontal: w * 0.03, vertical: h * 0.02),
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(number, style: AppStyle.textStyleLatoBoldBlack30,),
          Text(unit, style: AppStyle.textStyleLatoMediumGrey15,),
          Text(text, style: AppStyle.textStyleLatoBoldBlack20,),
        ],
      ),
    );
  }
}

class ResultTab1 extends StatelessWidget {
  ResultTab1({Key? key, required this.number, required this.unit, required this.text}) : super(key: key);


  final String number, unit, text;

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
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: w * 0.03, vertical: h * 0.02),
        decoration: BoxDecoration(
          color: cWhite,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(number, style: AppStyle.textStyleLatoBoldBlack30,),
            Text(unit, style: AppStyle.textStyleLatoMediumGrey15,),
            Text(text, style: AppStyle.textStyleLatoBoldBlack20,),
          ],
        ),
      ),
    );
  }
}






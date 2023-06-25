import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'excercise_detail_screen_logic.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:cached_network_image/cached_network_image.dart';



///comment

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
      backgroundColor: cWhite,
      appBar: AppBar(
        title: Text(
          controller.selectedExcerciseModel != null ? controller.selectedExcerciseModel!.value.excericeName : "",
            style: AppStyle.textStyleLatoBoldWhite20
        ),
        centerTitle: true,
        backgroundColor: cBlack,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(w * 0.05),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.selectedExcerciseModel != null ? Container(
                      width: w,
                      height: h * 0.3,
                      decoration: BoxDecoration(
                        color: cWhite,
                        boxShadow: [
                          BoxShadow(
                              color: cGrey,
                              spreadRadius: 1,
                              blurRadius: 10
                          )
                        ]
                      ),
                      child: CachedNetworkImage(
                        width: w,
                        height: h * 0.3,
                        imageUrl: controller.selectedExcerciseModel!.value.videoLink,
                        imageBuilder: (cnt, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: cBlack, width: 3),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain
                              ),
                            ),
                          );
                        },
                        placeholder: (cnt, url) =>
                            Container(
                              width: w,
                              height: h * 0.2,
                              color: Colors.black,
                            ),
                        errorWidget: (cnt, url, error) =>
                            Container(
                              width: w,
                              height: h * 0.2,
                              color: Colors.transparent,
                            ),
                      ),
                    ) : Container(),
                    SizedBox(height: h * 0.05,),
                    Text(
                      "Equipment:",
                      textAlign: TextAlign.left,
                      style: AppStyle.textStyleLatoBoldBlack25.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: h * 0.01,),
                    Text(
                      controller.selectedExcerciseModel != null ? controller.selectedExcerciseModel!.value.equipment : "",
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldBlack20,
                    ),
                    SizedBox(height: h * 0.03,),
                    Text(
                      "Description:",
                      textAlign: TextAlign.left,
                      style: AppStyle.textStyleLatoBoldBlack25.copyWith(
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: h * 0.01,),
                    Text(
                      controller.selectedExcerciseModel != null ? controller.selectedExcerciseModel!.value.description : "",
                      textAlign: TextAlign.justify,
                      style: AppStyle.textStyleLatoMediumBlack20,
                    ),
                    SizedBox(height: h * 0.15,),
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


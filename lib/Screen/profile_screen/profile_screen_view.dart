import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_screen_logic.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
                    "Profile Screen!",
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
  }
}


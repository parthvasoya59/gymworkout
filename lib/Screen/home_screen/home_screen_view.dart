import 'package:gymworkout/AppRoute/NavigationArgs.dart';
import 'package:gymworkout/AppRoute/app_route.dart';
import 'package:gymworkout/Constant/app_image.dart';
import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/widget/progress_bar.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'homemodel.dart';

class HomeScreenWidget extends GetView<HomeScreenLogic> {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<HomeScreenLogic>();
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: h * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: w * 0.6,
                    // color: cRed,
                    child: Text(
                      "Ignite Your Fitness Journey!",
                      // textAlign: TextAlign.center,
                      style: AppStyle.textStyleLatoBoldWhite25,
                    ),
                  ),
                  Container(
                    width: w * 0.25,
                    height: w * 0.25,
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
              Expanded(
                child: Obx(() {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    primary: true,
                    itemCount: controller.homeModelList.value.length,
                    separatorBuilder: (cnt, i) {
                      return SizedBox(height: h * 0.03,);
                    },
                    itemBuilder: (cnt, i) {
                      return GestureDetector(
                        onTap: (){
                          controller.onTapOfHomeTab(controller.homeModelList.value[i].txt);
                        },
                        child: HomeTab(
                          homeModel: controller.homeModelList.value[i],),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key, required this.homeModel}) : super(key: key);

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      width: double.maxFinite,
      height: h * 0.1,
      decoration: BoxDecoration(
          color: cWhite,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: w * 0.4,
            height: h * 0.1,
            // color: Colors.cyan,
            child: CachedNetworkImage(
              width: w * 0.4,
              height: h * 0.1,
              imageUrl: homeModel.imageUrl,
              imageBuilder: (cnt, imageProvider) {
                return Container(
                  // width: w * 0.5,
                  // height: h * 0.1,
                  decoration: BoxDecoration(
                    // color: cRed,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)
                      ),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill
                      )
                  ),
                );
              },
              placeholder: (cnt, url) =>
                  Container(
                    width: w * 0.4,
                    height: h * 0.1,
                    color: Colors.black,
                  ),
              errorWidget: (cnt, url, error) =>
                  Container(
                    width: w * 0.4,
                    height: h * 0.1,
                    color: Colors.transparent,
                  ),
            ),
          ),
          // Container(
          //   width: w * 0.5,
          //   height: h * 0.1,
          //   decoration: BoxDecoration(
          //       color: cRed,
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(15),
          //           bottomLeft: Radius.circular(15)
          //       ),
          //       image: DecorationImage(
          //           image: AssetImage(
          //             imageUrl,
          //           ),
          //           fit: BoxFit.cover,
          //           filterQuality: FilterQuality.high
          //       )
          //   ),
          // ),
          Flexible(
            child: Container(
              child: Center(
                child: Text(
                  homeModel.txt,
                  style: AppStyle.textStyleLatoBoldBlack25.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


/*
onTap: (){
        Get.toNamed(AppRoutes.excerciseScreen, arguments: {
          NavigationArgs.excerciseType: homeModel.txt + "MMG"
        });
      },
 */

import 'package:gymworkout/Constant/app_image.dart';
import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/hometab.dart';
import 'home_screen_logic.dart';

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




/*
onTap: (){
        Get.toNamed(AppRoutes.excerciseScreen, arguments: {
          NavigationArgs.excerciseType: homeModel.txt + "MMG"
        });
      },
 */

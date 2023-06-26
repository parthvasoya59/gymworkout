import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/Screen/home_screen/homemodel.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/excercisetab.dart';
import '../../widget/hometab.dart';
import 'excercise_screen_logic.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ExcerciseScreenWidget extends GetView<ExcerciseScreenLogic> {
  const ExcerciseScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ExcerciseScreenLogic>();
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Obx(() {
      debugPrint('getInitData => goalType : ${controller.goalType.value}');
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: h * 0.2,
            centerTitle: true,
            backgroundColor: cBlack,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${controller.excerciseType.value}', textScaleFactor: 1),
              background: controller.backImage.value == "" ? Container() : CachedNetworkImage(
                width: w,
                height: h * 0.2,
                imageUrl: "${controller.backImage.value}",
                imageBuilder: (cnt, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
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
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
                      child: Material(
                        child: GestureDetector(
                          onTap: (){
                            controller.onTapofExcerciseTab(index);
                          },
                          child: ExcerciseTab(
                            homeModel: HomeModel(imageUrl: controller.excerciseModelList.value[index].videoLink, txt: controller.excerciseModelList.value[index].excericeName)
                          ),
                        ),
                          // homeModel: controller.excerciseListFMG[index],),
                      ),
                    ),
                  ],
                );
              },
              childCount: controller.excerciseModelList.length,
            ),
          ),
        ]
      );
    });
  }
}


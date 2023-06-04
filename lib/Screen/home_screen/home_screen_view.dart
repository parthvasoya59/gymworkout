import 'package:gymworkout/Constant/app_image.dart';
import 'package:gymworkout/Constant/colors.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen_logic.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  primary: true,
                  itemCount: 10,
                  separatorBuilder: (cnt, i){
                    return SizedBox(height: h * 0.03,);
                  },
                  itemBuilder: (cnt, i){
                    return HomeTab(imageUrl: Assets.legshomem, txt: "Legs $i", onTapp: (){});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key, required this.imageUrl, required this.txt, required this.onTapp}) : super(key: key);

  final String imageUrl, txt;
  final VoidCallback onTapp;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTapp,
      child: Container(
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
              width: w * 0.5,
              height: h * 0.1,
              decoration: BoxDecoration(
                  color: cRed,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)
                  ),
                  image: DecorationImage(
                      image: AssetImage(
                        imageUrl,
                      ),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high
                  )
              ),
            ),
            Flexible(
              child: Container(
                child: Center(
                  child: Text(
                    txt,
                    style: AppStyle.textStyleLatoBoldBlack25.copyWith(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



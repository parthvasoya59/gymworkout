import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Constant/appstyle.dart';
import '../Constant/colors.dart';
import '../Screen/home_screen/homemodel.dart';

class ExcerciseTab extends StatelessWidget {
  const ExcerciseTab({Key? key, required this.homeModel}) : super(key: key);

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
          color: cGreyBack,
          // color: cGreyBack,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: w * 0.3,
            height: h * 0.1,
            color: cBlack,
            child: CachedNetworkImage(
              width: w * 0.3,
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
                    width: w * 0.3,
                    height: h * 0.1,
                    color: Colors.black,
                  ),
              errorWidget: (cnt, url, error) =>
                  Container(
                    width: w * 0.3,
                    height: h * 0.1,
                    color: Colors.transparent,
                  ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Container(
                decoration: BoxDecoration(
                    color: cGreyBack,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Text(
                    homeModel.txt,
                    textAlign: TextAlign.center,
                    style: AppStyle.textStyleLatoBoldBlack18.copyWith(
                        fontWeight: FontWeight.w600
                    ),
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
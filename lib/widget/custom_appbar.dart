import 'package:flutter/material.dart';

import '../Constant/appstyle.dart';

class CustomAppBar extends StatelessWidget {
  @override
  final Size preferredSize;

  String? title;
  final leading;
  final titleStyle;
  final List<Widget>? action;


  CustomAppBar({
    Key? key,
   this.title, this.leading, this.action, this.titleStyle,
  })  : preferredSize = Size.fromHeight(getVerticalSize(60)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top :getVerticalSize(20),left:getHorizontalSize(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading,
            Center(
              child: Text(
                title ?? '',
                style: titleStyle??AppStyle.textStyleLatoBoldWhite25,
              ),
            ),
            Row(
              children: action ?? [],
            ),

          ],
        ),
      ),
    );
  }
}

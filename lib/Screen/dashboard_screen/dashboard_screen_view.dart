import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/Screen/home_screen/home_screen_view.dart';
import 'package:gymworkout/Screen/notification_screen/notification_screen_view.dart';
import 'package:gymworkout/Screen/profile_screen/profile_screen_view.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_screen_logic.dart';

class DashboardScreenWidget extends GetView<DashboardScreenLogic> {
  const DashboardScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DashboardScreenLogic>();
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Obx(() {
      return Scaffold(
        backgroundColor: cBlack,
        key: controller.scaffoldKey,
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: [
            HomeScreenWidget(),
            NotificationScreenWidget(),
            ProfileScreenWidget()
          ],
        ),
        bottomNavigationBar:
          BottomNavigationBar(
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: cWhite,
            selectedItemColor: cGreen,
            unselectedItemColor: cBlack,
            showUnselectedLabels: true,
            unselectedLabelStyle: AppStyle.textStyleLatoMediumBlack15,
            selectedLabelStyle: AppStyle.textStyleLatoBoldBlack18,
            items: [...controller.bottomNavigationBarItemsofDriver],
          ),
      );
    });
  }
}


import 'package:gymworkout/Constant/colors.dart';
import 'package:gymworkout/Screen/goal_screen/goal_screen_view.dart';
import 'package:gymworkout/Screen/home_screen/home_screen_view.dart';
import '../../Constant/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../gender_sel_screen/gender_sel_screen_view.dart';
import 'dashboard_screen_logic.dart';

class DashboardScreenWidget extends GetView<DashboardScreenLogic> {
  const DashboardScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DashboardScreenLogic>();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cBlack,
      key: controller.scaffoldKey,
      body: IndexedStack(
        index: controller.tabIndex.value,
        children: [
          HomeScreenWidget(),
          GoalScreenWidget(),
          GenderSelScreenWidget()
        ],
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        onTap: controller.changeTabIndex,
        currentIndex: controller.tabIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: cBlue,
        unselectedItemColor: cGrey,
        showUnselectedLabels: true,
        unselectedLabelStyle: AppStyle.textStyleLatoMediumBlack20,
        selectedLabelStyle: AppStyle.textStyleLatoBoldBlack25,
        items: [...controller.bottomNavigationBarItemsofDriver],
      ),
    );
  }
}


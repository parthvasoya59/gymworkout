import 'package:get/get.dart';
import 'package:gymworkout/Screen/bmi_screen/bmi_screen_logic.dart';

import 'Screen/area_screen/area_screen_logic.dart';
import 'Screen/dashboard_screen/dashboard_screen_logic.dart';
import 'Screen/excercise_screen/excercise_screen_logic.dart';
import 'Screen/gender_sel_screen/gender_sel_screen_logic.dart';
import 'Screen/goal_screen/goal_screen_logic.dart';
import 'Screen/height_screen/height_screen_logic.dart';
import 'Screen/home_screen/home_screen_logic.dart';
import 'Screen/loading_screen/loading_screen_logic.dart';
import 'Screen/notification_screen/notification_screen_logic.dart';
import 'Screen/profile_screen/profile_screen_logic.dart';
import 'Screen/weight_screen/weight_screen_logic.dart';

class GenderSelScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenderSelScreenLogic());
  }
}

class AreaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AreaScreenLogic());
  }
}

class HeightScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HeightScreenLogic());
  }
}

class WeightScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeightScreenLogic());
  }
}

class BmiScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BmiScreenLogic());
  }
}

class GoalScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoalScreenLogic());
  }
}

class LoadingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoadingScreenLogic());
  }
}

class DashboardScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardScreenLogic());
  }
}

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeScreenLogic>(HomeScreenLogic());
    // Get.lazyPut(() => HomeScreenLogic());
  }
}

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileScreenLogic>(ProfileScreenLogic());
    // Get.lazyPut(() => ProfileScreenLogic());
  }
}

class NotificationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NotificationScreenLogic>(NotificationScreenLogic());
    // Get.lazyPut(() => NotificationScreenLogic());
  }
}

class ExcerciseScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExcerciseScreenLogic());
  }
}

import 'package:get/get.dart';
import 'package:gymworkout/Screen/area_screen/area_screen_view.dart';
import 'package:gymworkout/Screen/bmi_screen/bmi_screen_view.dart';
import 'package:gymworkout/Screen/goal_screen/goal_screen_view.dart';
import 'package:gymworkout/Screen/height_screen/height_screen_view.dart';
import 'package:gymworkout/Screen/update_profile_screen/update_profile_screen_view.dart';
import 'package:gymworkout/Screen/weight_screen/weight_screen_view.dart';
import '../Screen/calculator_screen/calculator_screen_view.dart';
import '../Screen/dashboard_screen/dashboard_screen_view.dart';
import '../Screen/excercise_detail_screen/excercise_detail_screen_view.dart';
import '../Screen/excercise_screen/excercise_screen_view.dart';
import '../Screen/gender_sel_screen/gender_sel_screen_view.dart';
import '../Screen/home_screen/home_screen_view.dart';
import '../Screen/loading_screen/loading_screen_view.dart';
import '../Screen/profile_screen/profile_screen_view.dart';
import '../Screen/result_screen/result_screen_view.dart';
import '../allbindings.dart';

class AppRoutes {
  static String genderSelScreen = '/gender_sel_Screen';
  static String areaScreen = '/area_Screen';
  static String heightScreen = '/height_Screen';
  static String weightScreen = '/weight_Screen';
  static String bmiScreen = '/bmi_Screen';
  static String goalScreen = '/goal_Screen';
  static String loadingScreen = '/loading_Screen';
  static String dashboardScreen = '/Dashboard_Screen';
  static String homeScreen = '/home_Screen';
  static String notificationScreen = '/notification_Screen';
  static String profileScreen = '/profile_Screen';
  static String updateProfileScreen = '/update_Profile_Screen';
  static String excerciseScreen = '/excercise_Screen';
  static String excerciseDetailScreen = '/excerciseDetail_Screen';
  static String resultScreen = '/result_Screen';

  static List<GetPage> pages = [
    GetPage(
      name: genderSelScreen,
      page: () => const GenderSelScreenWidget(),
      bindings: [GenderSelScreenBinding()],
    ),
    GetPage(
      name: areaScreen,
      page: () => const AreaScreenWidget(),
      bindings: [AreaScreenBinding()],
    ),
    GetPage(
      name: heightScreen,
      page: () => const HeightScreenWidget(),
      bindings: [HeightScreenBinding()],
    ),
    GetPage(
      name: weightScreen,
      page: () => const WeightScreenWidget(),
      bindings: [WeightScreenBinding()],
    ),
    GetPage(
      name: bmiScreen,
      page: () => const BmiScreenWidget(),
      bindings: [BmiScreenBinding()],
    ),
    GetPage(
      name: goalScreen,
      page: () => const GoalScreenWidget(),
      bindings: [GoalScreenBinding()],
    ),
    GetPage(
      name: loadingScreen,
      page: () => const LoadingScreenWidget(),
      bindings: [LoadingScreenBinding()],
    ),
    GetPage(
      name: dashboardScreen,
      page: () => const DashboardScreenWidget(),
      bindings: [DashboardScreenBinding(), HomeScreenBinding(), CalculatorScreenBinding(), ProfileScreenBinding()],
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreenWidget(),
      // bindings: [HomeScreenBinding()],
    ),
    GetPage(
      name: notificationScreen,
      page: () => const CalculatorScreenWidget(),
      // bindings: [NotificationScreenBinding()],
    ),
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreenWidget(),
      // bindings: [ProfileScreenBinding()],
    ),
    GetPage(
      name: excerciseScreen,
      page: () => const ExcerciseScreenWidget(),
      bindings: [ExcerciseScreenBinding()],
    ),
    GetPage(
      name: excerciseDetailScreen,
      page: () => const ExcerciseDetailScreenWidget(),
      bindings: [ExcerciseDetailScreenBinding()],
    ),
    GetPage(
      name: updateProfileScreen,
      page: () => const UpdateProfileScreenWidget(),
      bindings: [UpdateProfileScreenBinding()],
    ),
    GetPage(
      name: resultScreen,
      page: () => const ResultScreenWidget(),
      bindings: [ResultScreenBinding()],
    ),
  ];
}

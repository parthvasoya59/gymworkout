import 'package:get/get.dart';
import 'package:gymworkout/Screen/area_screen/area_screen_view.dart';
import 'package:gymworkout/Screen/height_screen/height_screen_view.dart';
import '../Screen/gender_sel_screen/gender_sel_screen_view.dart';
import '../allbindings.dart';

class AppRoutes {
  static String genderSelScreen = '/gender_sel_Screen';
  static String areaScreen = '/area_Screen';
  static String heightScreen = '/height_Screen';

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
  ];
}

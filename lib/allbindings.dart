import 'package:get/get.dart';

import 'Screen/area_screen/area_screen_logic.dart';
import 'Screen/gender_sel_screen/gender_sel_screen_logic.dart';
import 'Screen/height_screen/height_screen_logic.dart';

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

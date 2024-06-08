import 'package:get/get.dart';
import 'package:libgen/modules/bottom_navigation_bar/bottom_navigation_bar_logic.dart';
import 'package:libgen/modules/search_page/search_page_binding.dart';
import 'package:libgen/modules/search_page/search_page_logic.dart';

import 'home_page_logic.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageLogic());
  }
}

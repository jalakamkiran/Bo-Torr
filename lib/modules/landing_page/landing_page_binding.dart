import 'package:get/get.dart';
import 'package:libgen/modules/home_page/home_page.dart';
import 'package:libgen/modules/home_page/home_page_logic.dart';
import 'package:libgen/modules/library/library_logic.dart';
import 'package:libgen/modules/search_page/search_page_logic.dart';

import 'landing_page_logic.dart';

class LandingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingPageLogic());
    Get.lazyPut(()=> HomePageLogic());
    Get.lazyPut(()=> SearchPageLogic());
    Get.lazyPut(()=> LibraryLogic());
  }
}

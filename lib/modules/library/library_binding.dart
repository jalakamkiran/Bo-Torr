import 'package:get/get.dart';

import 'library_logic.dart';

class LibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LibraryLogic());
  }
}

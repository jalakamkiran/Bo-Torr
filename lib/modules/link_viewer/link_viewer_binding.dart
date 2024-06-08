import 'package:get/get.dart';

import 'link_viewer_logic.dart';

class LinkViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LinkViewerLogic());
  }
}

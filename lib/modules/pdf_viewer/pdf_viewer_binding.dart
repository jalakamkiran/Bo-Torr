import 'package:get/get.dart';

import 'pdf_viewer_logic.dart';

class PdfViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PdfViewerLogic());
  }
}

import 'package:get/get.dart';

import 'book_view_logic.dart';

class BookViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookViewLogic());
  }
}

import 'package:get/get.dart';
import 'package:libgen/models/home_page_model.dart';


class BookViewLogic extends GetxController {

  late Books book;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if(arguments['book'] != null){
      book = Books.fromJson(arguments['book']);
    }
  }
}

import 'package:get/get.dart';


class PdfViewerLogic extends GetxController {

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  late String downloadUrl;

  void onAfterlayout() {
    var arguments = Get.arguments;
    downloadUrl = arguments['downloadUrl'];
    isLoading = false;
  }


}

import 'package:get/get.dart';

class PdfViewerLogic extends GetxController {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  int _pageProgress = 0;

  int get pageProgress => _pageProgress;

  set pageProgress(int value) {
    _pageProgress = value;
  }

  late String downloadUrl;
  late String totalPages;

  void onAfterlayout() {
    var arguments = Get.arguments;
    downloadUrl = arguments['downloadUrl'];
    totalPages = arguments['totalPages'];
    isLoading = false;
  }

  calculatePagesDownloaded(double downloadPercentage) {
    pageProgress = ((downloadPercentage / 100) * int.parse(totalPages)).round();
  }
}

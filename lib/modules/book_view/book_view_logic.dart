import 'package:get/get.dart';
import 'package:libgen/data/repository/book_view_repository.dart';
import 'package:libgen/models/api_response.dart';
import 'package:libgen/models/book_download_model.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/routes/app_routes.dart';

class BookViewLogic extends GetxController {
  late Books book;

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments['book'] != null) {
      book = Books.fromJson(arguments['book']);
    }
  }

  onReadNowTapped() async {
    BookDownloadModel bookDownloadModel =
        await BookViewRepository().bookDownloadUrl(book.md5);
    switch (bookDownloadModel.apiResponse.responseState) {
      case ResponseState.success:
        Get.toNamed(AppRoutes.pdfViewer,
            arguments: {'downloadUrl': bookDownloadModel.downloadLink});
        break;
      default:
      //handle api errors
    }
  }
}

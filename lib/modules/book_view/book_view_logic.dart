import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:libgen/data/repository/book_view_repository.dart';
import 'package:libgen/models/api_response.dart';
import 'package:libgen/models/book_download_model.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/modules/utils/book_data.dart';
import 'package:libgen/modules/utils/local_files_fetcher.dart';
import 'package:libgen/routes/app_routes.dart';

class BookViewLogic extends GetxController {
  late Books book;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
    update();
  }

  @override
  void onInit() async{
    var arguments = Get.arguments;
    if (arguments['book'] != null) {
      book = Books.fromJson(arguments['book']);
    }
    isFavorite = await LocalFilesFetcher.checkIfFavorite(book);
  }

  onReadNowTapped() async {
    isLoading = true;
    BookData bookData = BookData();
    bookData.selectedBook = book;
    bool result = await InternetConnection().hasInternetAccess;
    if (result) {
      await _downloadBook();
    } else {
      //Internet is not there so fetch from local
      Get.toNamed(AppRoutes.pdfViewer,
          arguments: {'downloadUrl': '', 'books': bookData.selectedBook});
      isLoading = false;
    }
  }

  Future<void> _downloadBook() async {
    BookDownloadModel bookDownloadModel =
        await BookViewRepository().bookDownloadUrl(book.md5);
    switch (bookDownloadModel.apiResponse.responseState) {
      case ResponseState.success:
        Get.toNamed(AppRoutes.pdfViewer, arguments: {
          'downloadUrl': bookDownloadModel.downloadLink,
          'books': book
        });
        isLoading = false;
        break;
      default:
        break;
      //hanbreakdle api errors
    }
  }

  void onFavoriteTapped() async {
    if(await LocalFilesFetcher.checkIfFavorite(book)){
      await LocalFilesFetcher.removeFavorite(book);
      isFavorite = false;
    }
    else{
      await LocalFilesFetcher.setFavoriteBooks(book);
      isFavorite = true;
    }
  }
}

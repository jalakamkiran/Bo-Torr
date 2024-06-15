import 'package:get/get.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/modules/utils/local_files_fetcher.dart';

class LibraryLogic extends GetxController {
  List<Books> downloads = [];

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  @override
  void onInit() async{
    await onRefresh();
  }

  Future<void> onRefresh() async {
     isLoading = true;
    downloads = await LocalFilesFetcher.fetchDownloadedFiles();
    isLoading = false;
  }
}

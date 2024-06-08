import 'package:get/get.dart';
import 'package:libgen/data/repository/home_page_repository.dart';
import 'package:libgen/models/api_response.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/src/utils/bone_mock.dart';

enum HomePageState { loading, success, error }

class HomePageLogic extends GetxController {
  HomePageState _homePageState = HomePageState.loading;

  HomePageState get homePageState => _homePageState;

  set homePageState(HomePageState value) {
    if (value == HomePageState.loading) {
      _addFakeBooks();
    }
    _homePageState = value;
    update();
  }

  _addFakeBooks() {
    books = List.filled(
        8,
        Books(
            id: BoneMock.name,
            title: BoneMock.title,
            author: BoneMock.name,
            md5: BoneMock.name,
            language: BoneMock.name,
            pages: BoneMock.phone,
            coverurl: BoneMock.name,
            topic: BoneMock.name));
  }

  List<Books> books = [];

  fetchRecomendedBooks() async {
    homePageState = HomePageState.loading;
    HomePageModel homePageModel =
        await HomePageRepository().getHomePage(_parseHomePageBody());
    switch (homePageModel.apiResponse.responseState) {
      case ResponseState.success:
        books = homePageModel.books;
        homePageState = HomePageState.success;
        Get.log("Success ${homePageModel.books.length}");
        break;
      default:
        Get.log("Some error");
        homePageState = HomePageState.error;
    }
  }

  _parseHomePageBody() {
    // Get the current date
    DateTime toDate = DateTime.now();
    // Subtract one year from the current date
    DateTime fromDate = DateTime(toDate.year - 1, toDate.month, toDate.day);
    // Format the dates as strings (e.g., 'yyyy-MM-dd')
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String fromDateString = dateFormat.format(fromDate);
    String toDateString = dateFormat.format(toDate);

    // Create the map
    Map<String, String> dateMap = {
      'fromDate': "2023-01-03",
      'toDate': toDateString
    };
    return dateMap;
  }

  onAfterlayout() async {
    _addFakeBooks();
    await fetchRecomendedBooks();
  }
}

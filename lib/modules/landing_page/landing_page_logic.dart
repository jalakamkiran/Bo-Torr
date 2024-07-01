import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:libgen/res.dart';
import 'package:libgen/routes/app_routes.dart';

enum BottomNavigationBarState { home, search, library, profile }

class LandingPageLogic extends GetxController {
  BottomNavigationBarState _bottomNavigationBarState =
      BottomNavigationBarState.home;

  BottomNavigationBarState get bottomNavigationBarState =>
      _bottomNavigationBarState;

  set bottomNavigationBarState(BottomNavigationBarState state) {
    _bottomNavigationBarState = state;
    update();
  }

  List<BottomNavigationBarModel> bottomNavigationBarItems = [
    BottomNavigationBarModel(
        title: 'Home',
        icon: Res.home_page_icon,
        route: AppRoutes.homePage,
        state: BottomNavigationBarState.home),
    BottomNavigationBarModel(
        title: 'Search',
        icon: Res.search_icon,
        route: AppRoutes.search,
        state: BottomNavigationBarState.search),
    BottomNavigationBarModel(
        title: 'Library',
        icon: Res.book_icon,
        route: AppRoutes.homePage,
        state: BottomNavigationBarState.library),
  ];

  void onItemTapped(int index) {
    bottomNavigationBarState = bottomNavigationBarItems[index].state;
  }

  @override
  void onInit() async {
    bool result = await InternetConnection().hasInternetAccess;
    if (!result) bottomNavigationBarState = BottomNavigationBarState.library;
  }
}

class BottomNavigationBarModel {
  String title;
  String icon;
  BottomNavigationBarState state;
  String route;

  BottomNavigationBarModel(
      {required this.title,
      required this.icon,
      required this.state,
      required this.route});
}

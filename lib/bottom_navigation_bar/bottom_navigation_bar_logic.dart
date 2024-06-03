import 'package:get/get.dart';
import 'package:libgen/res.dart';

enum BottomNavigationBarState { home, search, library, profile }

class BottomNavigationBarLogic extends GetxController {
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
        state: BottomNavigationBarState.home),
    BottomNavigationBarModel(
        title: 'Search',
        icon: Res.search_icon,
        state: BottomNavigationBarState.search),
    BottomNavigationBarModel(
        title: 'Library',
        icon: Res.book_icon,
        state: BottomNavigationBarState.library),
    BottomNavigationBarModel(
        title: 'Profile',
        icon: Res.profile_icon,
        state: BottomNavigationBarState.profile),
  ];

  void onItemTapped(int index) {
    bottomNavigationBarState = bottomNavigationBarItems[index].state;
    update();
  }
}

class BottomNavigationBarModel {
  String title;
  String icon;
  BottomNavigationBarState state;

  BottomNavigationBarModel(
      {required this.title, required this.icon, required this.state});
}

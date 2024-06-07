// import 'package:get/get.dart';
// import 'package:libgen/res.dart';
// import 'package:libgen/routes/app_routes.dart';
//
// enum BottomNavigationBarState { home, search, library, profile }
//
// class BottomNavigationBarLogic extends GetxController {
//   BottomNavigationBarState _bottomNavigationBarState =
//       BottomNavigationBarState.home;
//
//   BottomNavigationBarState get bottomNavigationBarState =>
//       _bottomNavigationBarState;
//
//   set bottomNavigationBarState(BottomNavigationBarState state) {
//     _bottomNavigationBarState = state;
//     update();
//   }
//
//   List<BottomNavigationBarModel> bottomNavigationBarItems = [
//     BottomNavigationBarModel(
//         title: 'Home',
//         icon: Res.home_page_icon,
//         route: AppRoutes.homePage,
//         state: BottomNavigationBarState.home),
//     BottomNavigationBarModel(
//         title: 'Search',
//         icon: Res.search_icon,
//         route: AppRoutes.search,
//         state: BottomNavigationBarState.search),
//     BottomNavigationBarModel(
//         title: 'Library',
//         icon: Res.book_icon,
//         route: AppRoutes.homePage,
//         state: BottomNavigationBarState.library),
//     BottomNavigationBarModel(
//         title: 'Profile',
//         icon: Res.profile_icon,
//         route: AppRoutes.homePage,
//         state: BottomNavigationBarState.profile),
//   ];
//
//   void onItemTapped(int index) {
//     bottomNavigationBarState = bottomNavigationBarItems[index].state;
//     Get.toNamed(bottomNavigationBarItems[index].route);
//   }
// }
//
// class BottomNavigationBarModel {
//   String title;
//   String icon;
//   BottomNavigationBarState state;
//   String route;
//
//   BottomNavigationBarModel(
//       {required this.title, required this.icon, required this.state,required this.route});
// }

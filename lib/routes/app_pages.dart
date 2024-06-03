import 'package:get/get.dart';
import 'package:libgen/modules/book_view/book_view_binding.dart';
import 'package:libgen/modules/book_view/book_view.dart';
import 'package:libgen/modules/home_page/home_page.dart';
import 'package:libgen/modules/home_page/home_page_binding.dart';
import 'package:libgen/routes/app_pages.dart';
import 'package:libgen/routes/app_routes.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutes.homePage,
      binding: HomePageBinding(),
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.bookView,
      binding: BookViewBinding(),
      page: () => BookViewPage(),
    ),
  ];
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/modules/book_view/book_view_binding.dart';
import 'package:libgen/modules/book_view/book_view.dart';
import 'package:libgen/modules/home_page/home_page.dart';
import 'package:libgen/modules/home_page/home_page_binding.dart';
import 'package:libgen/modules/landing_page/landing_page_binding.dart';
import 'package:libgen/modules/landing_page/landing_page.dart';
import 'package:libgen/modules/link_viewer/link_viewer.dart';
import 'package:libgen/modules/link_viewer/link_viewer_binding.dart';
import 'package:libgen/modules/pdf_viewer/pdf_viewer_binding.dart';
import 'package:libgen/modules/pdf_viewer/pdf_viewer_view.dart';
import 'package:libgen/modules/search_page/search_page_binding.dart';
import 'package:libgen/modules/search_page/search_page_view.dart';
import 'package:libgen/modules/splash_screen/splash_screen_binding.dart';
import 'package:libgen/modules/splash_screen/splash_screen_view.dart';
import 'package:libgen/routes/app_routes.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splashScreen,
      binding: SplashScreenBinding(),
      page: () => SplashScreenPage(),
    ),
    GetPage(
      name: AppRoutes.landingPage,
      binding: LandingPageBinding(),
      page: () => LandingPage(),
    ),
    GetPage(
      name: AppRoutes.homePage,
      binding: HomePageBinding(),
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.bookView,
      binding: BookViewBinding(),
      customTransition: SmoothTransition(),
      transition: Transition.noTransition,
      curve: Curves.linear,
      transitionDuration: Duration(milliseconds: 200),
      page: () => BookViewPage(),
    ),
    GetPage(
      name: AppRoutes.pdfViewer,
      binding: PdfViewerBinding(),
      page: () => PdfViewerPage(),
    ),
    GetPage(
      name: AppRoutes.search,
      binding: SearchPageBinding(),
      page: () => SearchPageView(),
    ),
    GetPage(
      name: AppRoutes.linkViewer,
      binding: LinkViewerBinding(),
      page: () => LinkViewer(),
    ),
  ];
}

class NoTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class SmoothTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return  FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/app_theme.dart';
import 'package:libgen/common_widgets/bottom_navigation_bar_view.dart';
import 'package:libgen/modules/home_page/home_page.dart';
import 'package:libgen/modules/library/library_view.dart';
import 'package:libgen/modules/search_page/search_page_view.dart';

import 'landing_page_logic.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final logic = Get.find<LandingPageLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _backgroundDecoration(),
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<LandingPageLogic>(
            builder: (logic) {
              switch(logic.bottomNavigationBarState){
                case BottomNavigationBarState.home:
                  return HomePage();
                case BottomNavigationBarState.search:
                  return SearchPageView();
                case BottomNavigationBarState.library:
                  return LibraryPage();
                case BottomNavigationBarState.profile:
                  return const Center(child: Text("Profile"));
                default:
                  return const Center(child: Text("Home"));
              }
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBarView(),
      ),
    );
  }

  BoxDecoration _backgroundDecoration() {
    return BoxDecoration(
      gradient: AppTheme.appGradient,
    );
  }
}

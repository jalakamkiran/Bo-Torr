import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:after_layout/after_layout.dart';
import 'package:libgen/app_theme.dart';
import 'package:libgen/modules/bottom_navigation_bar/bottom_navigation_bar_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'home_page_logic.dart';
import 'widgets/list_books.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
  final logic = Get.find<HomePageLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _backgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GetBuilder<HomePageLogic>(builder: (logic) {
              return Skeletonizer(
                containersColor: Colors.red,
                ignoreContainers: false,
                justifyMultiLineText: true,
                enabled: logic.homePageState == HomePageState.loading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Popular",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ListBooks(),
                  ],
                ),
              );
            }),
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

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    logic.onAfterlayout();
  }
}

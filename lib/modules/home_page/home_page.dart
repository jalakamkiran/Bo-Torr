import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:after_layout/after_layout.dart';
import 'package:libgen/app_theme.dart';
import 'package:libgen/common_widgets/report_bug.dart';
import 'package:libgen/res.dart';
import 'package:lottie/lottie.dart';
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<HomePageLogic>(builder: (logic) {
            switch (logic.homePageState) {
              case HomePageState.error:
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 3,
                        child: LottieBuilder.asset(
                          Res.networkError,
                          fit: BoxFit.fitWidth,
                        ))
                  ],
                );
              default:
                return _homepage(logic);
            }
          }),
        ),
      ),
    );
  }

  Skeletonizer _homepage(HomePageLogic logic) {
    return Skeletonizer(
      containersColor: Colors.red,
      ignoreContainers: false,
      justifyMultiLineText: true,
      enabled: logic.homePageState == HomePageState.loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Text(
                    "Popular",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                ReportBug(),
              ],
            ),
          ),
          ListBooks(
            books: logic.books,
          ),
        ],
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

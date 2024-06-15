import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/app_theme.dart';
import 'package:libgen/common_widgets/report_bug.dart';
import 'package:libgen/modules/home_page/widgets/list_books.dart';
import 'package:libgen/res.dart';
import 'package:lottie/lottie.dart';

import 'library_logic.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({Key? key}) : super(key: key);

  final logic = Get.find<LibraryLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LibraryLogic>(builder: (logic) {
      return Container(
        decoration: _backgroundDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Text(
                        "Downloads",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    ReportBug(),
                  ],
                ),
              ),
              !logic.isLoading
                  ? ListBooks(books: logic.downloads)
                  : Expanded(child: _noDownloads() ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                    onTap: (){
                      logic.onRefresh();
                    },
                    child: Text("Refresh")),
              )
            ],
          ),
        ),
      );
    });
  }

  Column _noDownloads() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        Lottie.asset(Res.noDownload),
        Text("No downloads yet. Start reading some books."),
        const Spacer(),
      ],
    );
  }

  BoxDecoration _backgroundDecoration() {
    return BoxDecoration(
      gradient: AppTheme.appGradient,
    );
  }
}

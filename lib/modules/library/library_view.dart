import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libgen/app_theme.dart';
import 'package:libgen/common_widgets/report_bug.dart';
import 'package:libgen/modules/home_page/widgets/list_books.dart';
import 'package:libgen/modules/library/widgets/favorites.dart';
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
        height: double.infinity,
        decoration: _backgroundDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Library",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    ReportBug(),
                  ],
                ),
              ),
              const Flexible(
                child: Text(
                  "Favorites",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 10,),
              if (!logic.isLoading) ...[
                Expanded(
                  flex: 3,
                  child: Favorites(
                    books: logic.books,
                  ),
                ),
                const SizedBox(height: 20,),
                const Flexible(
                  child: Text(
                    "Downloads",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                ListBooks(books: logic.downloads)
              ],
              if (logic.isLoading)
                Expanded(
                  flex: 3,
                  child: _noDownloads(),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: InkWell(
                      onTap: () {
                        logic.onRefresh();
                      },
                      child: Text("Refresh")),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Column _noDownloads() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Lottie.asset(Res.noDownload),
        const Flexible(
            child: Text("No downloads yet. Start reading some books.")),
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

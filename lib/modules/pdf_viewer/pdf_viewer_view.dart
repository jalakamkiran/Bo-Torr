import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:after_layout/after_layout.dart';
import 'package:libgen/app_theme.dart';
import 'package:libgen/res.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'pdf_viewer_logic.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  PdfViewerPage({Key? key}) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> with AfterLayoutMixin {
  final logic = Get.find<PdfViewerLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.appGradient,
        ),
        child: GetBuilder<PdfViewerLogic>(
          builder: (logic) {
            if (logic.isLoading) {
              return  Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RiveAnimation.asset(Res.fetchingBook)
                ],
              );
            }
            return PDF().cachedFromUrl(
              logic.downloadUrl,
              placeholder: (double progress){
                Get.log("progress is $progress");
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: RiveAnimation.asset(Res.fetchingBook))
                  ],
                );
              },
              errorWidget: (error) {
                Get.log("Error is $error");
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 3,
                        child: LottieBuilder.asset(Res.networkError,fit: BoxFit.fitWidth,))
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    logic.onAfterlayout();
  }
}

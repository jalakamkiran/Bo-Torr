import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:after_layout/after_layout.dart';
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
    if(logic.isLoading){
      return const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      );
    }
    return PDF().cachedFromUrl(
      logic.downloadUrl,
      placeholder: (double progress) => CircularProgressIndicator(),
      errorWidget: (error) {
        Get.log("Error is $error");
        return Text("An error occured");
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    logic.onAfterlayout();
  }
}

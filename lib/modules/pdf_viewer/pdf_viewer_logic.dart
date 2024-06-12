import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class PdfViewerLogic extends GetxController {
  bool _isLoading = true;


  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  int _pageProgress = 0;

  int get pageProgress => _pageProgress;

  set pageProgress(int value) {
    _pageProgress = value;
  }

  String filePath = "";

  late String downloadUrl;
  late String totalPages;
  late String md5;

  @override
  void onInit() {
    var arguments = Get.arguments;
    downloadUrl = arguments['downloadUrl'];
    totalPages = arguments['totalPages'];
    md5 = arguments['md5'];
    if (!downloadUrl.contains("pdf")) {
      downloadEpub();
    }
    super.onInit();
  }

  calculatePagesDownloaded(double downloadPercentage) {
    try {
      pageProgress =
          ((downloadPercentage / 100) * int.parse(totalPages)).round();
    } catch (e, s) {}
  }

  downloadEpub() async {
    isLoading = true;

    try {
      final directory = await getApplicationDocumentsDirectory();
      filePath = path.join(directory.path, '$md5.epub');
      final file = File(filePath);

      if (await file.exists()) {
        Get.back();
        VocsyEpub.setConfig(
          identifier: "iosBook",
          scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
          allowSharing: true,
          enableTts: true,
          nightMode: true,
        );
        VocsyEpub.open(
          filePath
        );

      } else {
        // Send a GET request to the provided URL
        await _onFileNotExists(file);
      }
    } catch (e) {
      // Handle any errors
      print('Error downloading file: $e');
      return "";
    }
  }

  Future<void> _onFileNotExists(File file) async {
    final response = await http.get(Uri.parse(downloadUrl));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Get the directory to save the file

      // Write the file to the local storage

      await file.writeAsBytes(response.bodyBytes);
      Get.back();
      VocsyEpub.setConfig(
        identifier: "iosBook",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
        nightMode: true,
      );
      VocsyEpub.open(
          filePath
      );
    } else {
      throw Exception('Failed to download file');
    }
  }

  String fetchProgressText() {
    try {
      return "${pageProgress}/${totalPages} Pages downloaded";
    } on Exception {
      return "";
    }
  }
}

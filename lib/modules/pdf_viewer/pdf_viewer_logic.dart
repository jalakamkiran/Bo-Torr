import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/modules/utils/local_files_fetcher.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sentry_flutter/sentry_flutter.dart';
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

  late Books books;

  @override
  void onInit() async{
    var arguments = Get.arguments;
    downloadUrl = arguments['downloadUrl'];
    books = arguments['books'];
    bool result = await InternetConnection().hasInternetAccess;
    if(result){
      checkForFileCache(downloadUrl.split('.').last);
    }
    else{
      //fetch file name from md5
      filePath = await LocalFilesFetcher.fetchLocalBookFromMd5(books.md5);
      _onFileExists();
      isLoading = false;
    }

    super.onInit();
  }

  calculatePagesDownloaded(double downloadPercentage) {
    try {
      pageProgress =
          ((downloadPercentage / 100) * int.parse(books.pages)).round();
    } catch (e, s) {}
  }



  checkForFileCache(String extension)async{
    isLoading = true;
    try {
      final directory = await getApplicationDocumentsDirectory();
      filePath = path.join(directory.path, '${books.md5}.$extension');
      final file = File(filePath);
      if(await file.exists()){
        _onFileExists();
      }
      else{
        _onFileNotExists(file);
      }
    } catch (e, s) {
      Sentry.captureException(e,stackTrace: s);
    }
  }

  Future<void> _onFileNotExists(File file) async {
    final response = await http.get(Uri.parse(downloadUrl));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Get the directory to save the file

      // Write the file to the local storage

      await file.writeAsBytes(response.bodyBytes);
      _onFileExists();
    } else {
      throw Exception('Failed to download file');
    }
  }

  String fetchProgressText() {
    try {
      return "${pageProgress}/${books.pages} Pages downloaded";
    } on Exception {
      return "";
    }
  }

  void _onFileExists() {
    localStorage.setItem(filePath, jsonEncode(books.toJson()));
    if (!filePath.contains("pdf")) {
      showEpub();
    }
    else{
      showPdf();
    }
  }

  void showEpub(){
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
  }

  void showPdf(){
    isLoading = false;
  }
}

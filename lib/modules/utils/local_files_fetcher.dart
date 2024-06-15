import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

class LocalFilesFetcher {
  static Future<List<Books>> fetchDownloadedFiles() async {
    List<Books> books = [];
    try {
      final directory = await getApplicationDocumentsDirectory();
      await directory.list().forEach((element) {
        if (element.path.contains(".pdf") || element.path.contains(".epub")) {
          String bookJson = localStorage.getItem(element.path) ?? "";
          books.add(Books.fromJson(jsonDecode(bookJson)));
        }
      });
    } catch (e, s) {
      print(s);
    }
    return books;
  }

  static Future<String> fetchLocalBookFromMd5(String md5) async {
    final directory = await getApplicationDocumentsDirectory();
    FileSystemEntity path = await directory
        .list()
        .where((element) => element.path.contains(md5))
        .first;
    return path.path;
  }
}

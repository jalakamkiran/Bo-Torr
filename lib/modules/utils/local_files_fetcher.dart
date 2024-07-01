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

  static Future<List<Books>> fetchFavoriteBooks() async {
    List<Books> books = [];
    String favJson = localStorage.getItem("favorite_books") ?? "";
    if(favJson.isNotEmpty){
      try {
        books = (jsonDecode(favJson) as List).map((e) => Books.fromJson(e)).toList();
      } catch (e, s) {
        books = [];
      }
    }
    return books;
  }

  static Future<void> removeFavorite(Books book) async {
    String favJson = localStorage.getItem("favorite_books") ?? "";
    if(favJson.isNotEmpty){
      Set<Books> bookSet = (jsonDecode(favJson) as List).map((e)=>Books.fromJson(e)).toSet();
      bookSet.removeWhere((e)=> e.id == book.id);
      localStorage.setItem("favorite_books", jsonEncode(bookSet.toList()));
    }
  }

  static Future<bool> checkIfFavorite(Books book) async {
    String favJson = localStorage.getItem("favorite_books") ?? "";
    if(favJson.isNotEmpty){
      try {
        Set<String> bookSet = (jsonDecode(favJson) as List).map((e) => Books.fromJson(e).id).toSet();
        return bookSet.contains(book.id);
      } catch (e, s) {
        return false;
      }

    }
    return false;
  }

  static Future<void> setFavoriteBooks(Books book) async {
    List<Books> books = await fetchFavoriteBooks();
    books.add(book);
    localStorage.setItem("favorite_books", jsonEncode(books));
  }
}

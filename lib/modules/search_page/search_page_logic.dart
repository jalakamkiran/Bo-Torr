import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libgen/data/repository/home_page_repository.dart';
import 'package:libgen/data/repository/search_repository.dart';
import 'package:libgen/models/api_response.dart';
import 'package:libgen/models/home_page_model.dart';

enum SearchPageState { loading, success, error ,idle}

class SearchPageLogic extends GetxController {

  SearchPageState _searchPageState = SearchPageState.idle;

  SearchPageState get searchPageState => _searchPageState;

  set searchPageState(SearchPageState value) {
    _searchPageState = value;
    update();
  }

  List<Books> searchResult = [];

  TextEditingController searchController = TextEditingController();

  final _debouncer = Debouncer(milliseconds: 500);

  void onSearchChanged(String value) {
    _debouncer.run((){
      _searchBooks(value);
    });
  }

  _searchBooks(String title)async{
    searchPageState = SearchPageState.loading;
    await Future.delayed(Duration(seconds: 2));
    HomePageModel homePageModel =
        await SearchRepository().searchForBook(title);
    switch (homePageModel.apiResponse.responseState) {
      case ResponseState.success:
        searchResult = homePageModel.books;
        searchPageState = SearchPageState.success;
        Get.log("Success ${homePageModel.books.length}");
        break;
      default:
        Get.log("Some error");
        searchPageState = SearchPageState.error;
    }
  }
}

class Debouncer {
  final int milliseconds;

  Timer? _timer;

  Debouncer({this.milliseconds=500});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

import 'dart:convert';

import 'package:libgen/models/api_response.dart';

HomePageModel homePageModelFromJson(ApiResponse apiResponse) {
  return HomePageModel.decodeResponse(apiResponse);
}

class HomePageModel {
  late List<Books> books;
  late ApiResponse apiResponse;

  HomePageModel.decodeResponse(ApiResponse apiResponse) {
    switch (apiResponse.responseState) {
      case ResponseState.success:
        parseJson(jsonDecode(apiResponse.apiResponse));
        this.apiResponse = apiResponse..responseState = ResponseState.success;
      default:
        this.apiResponse = apiResponse;
    }
  }

  parseJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['books'] = books.map((v) => v.toJson()).toList();
      return data;
  }
}

class Books {
  late String id;
  late String title;
  late String author;
  late String md5;
  late String language;
  late String coverurl;
  late String topic;
  late String pages;

  Books(
      {required this.id,
      required this.title,
      required this.author,
      required this.md5,
      required this.language,
      required this.coverurl,
        required this.pages,
      required this.topic});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'] ?? "";
    md5 = json['md5'];
    language = json['language'] ?? "English";
    coverurl = json['coverurl'];
    topic = json['topic'];
    pages = json['pages'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['md5'] = md5;
    data['language'] = language;
    data['coverurl'] = coverurl;
    data['topic'] = topic;
    data['pages'] = pages;
    return data;
  }
}

import 'dart:convert';

import 'package:libgen/models/api_response.dart';
import 'package:libgen/models/home_page_model.dart';

SearchModel searchModelFromJson(ApiResponse apiResponse) {
  return SearchModel.decodeResponse(apiResponse);
}

class SearchModel {
  late List<Books> books;
  late ApiResponse apiResponse;

  SearchModel.decodeResponse(ApiResponse apiResponse) {
    switch (apiResponse.responseState) {
      case ResponseState.success:
        try {
          parseJson(jsonDecode(apiResponse.apiResponse));
          this.apiResponse = apiResponse..responseState = ResponseState.success;
        } catch (e) {
          this.apiResponse = apiResponse
            ..responseState = ResponseState.jsonParsingError
            ..exception = e.toString();
        }
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

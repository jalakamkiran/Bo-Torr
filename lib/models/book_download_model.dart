import 'dart:convert';

import 'package:libgen/models/api_response.dart';

BookDownloadModel bookDownloadModelFromJson(ApiResponse apiResponse) {
  return BookDownloadModel.decodeResponse(apiResponse);
}

class BookDownloadModel {
  late List<dynamic> downloadLink;
  late ApiResponse apiResponse;

  BookDownloadModel({required this.downloadLink,required this.apiResponse});


  BookDownloadModel.decodeResponse(ApiResponse apiResponse) {
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
    if (json['download_link'] != null) {
      downloadLink = json['download_link'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['download_link'] = this.downloadLink;
    return data;
  }
}

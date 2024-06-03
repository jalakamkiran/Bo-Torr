import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:libgen/models/api_response.dart';

final httpClient = http.Client();

class HttpClient {
  static Future<Map<String, String>> getHeaders() async {
    return {"Content-Type": "application/json", "Accept": "application/json"};
  }

  static Future<ApiResponse> get({required String url}) async {
    try {
      Get.log("Perform Get request for $url");
      http.Response res =
          await httpClient.get(Uri.parse(url), headers: await getHeaders());
      Get.log("Status code ${res.statusCode}");
      Get.log("Response body  ${res.body}");
      switch (res.statusCode) {
        case 302:
        case 307:
          return _onApiResponseLocationHeader(res, {});
        default:
          return _fetchSuccessResponse(res, {});
      }
    } catch (exception) {
      return _fetchException(exception, url: url);
    }
  }

  static Future<ApiResponse> post(
      {required String url, Map<dynamic, dynamic>? body}) async {
    try {
      Get.log("Perform Post request for $url with request body ${body}");
      http.Response res = await httpClient.post(Uri.parse(url),
          headers: await getHeaders(), body: jsonEncode(body));
      Get.log("Status code ${res.statusCode}");
      Get.log("Response body  ${res.body}");
      switch (res.statusCode) {
        case 302:
        case 307:
          return _onApiResponseLocationHeader(res, {});
        default:
          return _fetchSuccessResponse(res, {});
      }
    } catch (exception) {
      return _fetchException(exception, url: url);
    }
  }

  static _fetchException(Object exception,
      {String? url, Map<dynamic, dynamic>? body}) {
    switch (exception.runtimeType) {
      case SocketException:
        Get.log("Socket exception $exception");
        return ApiResponse(
            responseState: ResponseState.failure,
            apiResponse: "Socket exception - $exception",
            url: url ?? "",
            statusCode: 0,
            requestBody: jsonEncode(body),
            exception: "Socket exception - $exception");
      case TimeoutException:
        return ApiResponse(
            responseState: ResponseState.failure,
            apiResponse: "TimeoutException - $exception",
            url: url ?? "",
            statusCode: 0,
            requestBody: jsonEncode(body),
            exception: "TimeoutException - $exception");
      case http.ClientException:
        return ApiResponse(
            responseState: ResponseState.failure,
            apiResponse: "ClientException - $exception",
            url: url ?? "",
            statusCode: 0,
            requestBody: jsonEncode(body),
            exception: "ClientException - $exception");
      default:
        return ApiResponse(
            responseState: ResponseState.failure,
            apiResponse: "Error $exception",
            url: url ?? "",
            statusCode: 0,
            requestBody: jsonEncode(body),
            exception: "");
    }
  }

  static Future<ApiResponse> _onApiResponseLocationHeader(
      http.Response res, Map body) async {
    try {
      final http.Response response =
          await httpClient.get(Uri.parse(res.headers['location']!));
      return _fetchSuccessResponse(response, body);
    } catch (exception) {
      Get.log("http request error $exception");
      return ApiResponse(
          responseState: ResponseState.failure,
          apiResponse: "Error $exception",
          url: Uri.parse(res.headers['location']!).path,
          statusCode: res.statusCode,
          requestBody: jsonEncode(body),
          exception: "");
    }
  }

  static Future<ApiResponse> _fetchSuccessResponse(
      http.Response res, Map body) async {
    switch (res.statusCode) {
      case 200:
      case 201:
        return await _computeApiResponse(res, ResponseState.success, body);
      case 400:
        return await _computeApiResponse(
            res, ResponseState.badRequestError, body);
      case 401:
      case 403:
        return await _computeApiResponse(res, ResponseState.unAuthorized, body);
      default:
        return await _computeApiResponse(res, ResponseState.failure, body);
    }
  }

  static Future<ApiResponse> _computeApiResponse(
      http.Response res, ResponseState state, Map body) async {
    return ApiResponse(
        responseState: state,
        apiResponse: utf8.decode(res.bodyBytes),
        url: res.request!.url.toString(),
        statusCode: res.statusCode,
        requestBody: jsonEncode(body),
        exception: "");
  }
}

enum ResponseState {
  success,
  failure,
  badRequestError,
  noInternet,
  unAuthorized,
  timedOut,
  jsonParsingError
}

class ApiResponse {
  ResponseState responseState;
  String apiResponse;
  String url;
  int statusCode;
  String requestBody;
  String exception;

  ApiResponse(
      {required this.responseState,
      required this.apiResponse,
      required this.url,
      required this.statusCode,
      required this.requestBody,
      required this.exception});

  @override
  String toString() {
    return 'ApiResponse{responseState: $responseState, apiResponse: $apiResponse, url: $url, statusCode: $statusCode, requestBody: $requestBody, exception: $exception}';
  }
}

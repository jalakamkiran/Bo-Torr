class BaseRepository {
  static final _baseUrl = "https://libgen-client.onrender.com";
  static final _apiVersion = "/api/v1";

  String get baseUrl {
    return _baseUrl + _apiVersion;
  }
}

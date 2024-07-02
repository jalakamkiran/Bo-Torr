import 'package:libgen/api/http_client.dart';
import 'package:libgen/data/repository/base_repository.dart';
import 'package:libgen/models/api_response.dart';
import 'package:libgen/models/home_page_model.dart';
import 'package:libgen/models/search_model.dart';

class SearchRepository extends BaseRepository{

  Future<SearchModel> searchForBook(String searchText) async {
    ApiResponse response = await HttpClient.get(url: "${baseUrl}/home_page/search/${searchText}");
    return searchModelFromJson(response);
  }
}
import 'package:libgen/api/http_client.dart';
import 'package:libgen/data/repository/base_repository.dart';
import 'package:libgen/models/api_response.dart';
import 'package:libgen/models/home_page_model.dart';

class HomePageRepository extends BaseRepository {
  Future<HomePageModel> getHomePage(Map<String, dynamic> body) async {
    ApiResponse response =
        await HttpClient.post(url: "${baseUrl}/home_page/", body: body);
    return homePageModelFromJson(response);
  }
}

import 'package:libgen/api/http_client.dart';
import 'package:libgen/data/repository/base_repository.dart';
import 'package:libgen/models/api_response.dart';
import 'package:libgen/models/book_download_model.dart';

class BookViewRepository extends BaseRepository {
  Future<BookDownloadModel> bookDownloadUrl(String id) async {
    ApiResponse response = await HttpClient.get(
      url: "$baseUrl/home_page/download/$id"
    );
    return bookDownloadModelFromJson(response);
  }
}

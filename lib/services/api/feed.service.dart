import 'package:ekank/helpers/http_helpers/api_constant.dart';
import 'package:ekank/helpers/http_helpers/api_result.dart';
import 'package:ekank/helpers/http_helpers/network_exceptions.dart';
import 'package:ekank/models/article_model.dart';
import 'package:ekank/services/base.service.dart';

class FeedService extends BaseService {
  Future<ApiResult<List<Article>>> fetchFeedContent({required int page}) async {
    try {
      final response = await dioClient
          .get(ApiConstant.everyThingQuery, queryParameters: {"page": page});

      List<Article> articleList = response['articles']
          .map<Article>((article) => Article.fromJson(article))
          .toList();

      return ApiResult.success(data: articleList);
    } catch (e) {
      print(e);
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}

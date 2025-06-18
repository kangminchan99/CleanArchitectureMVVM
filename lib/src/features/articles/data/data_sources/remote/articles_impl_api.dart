import 'package:cleanarchitecture/src/core/utils/constant/network_constant.dart';
import 'package:cleanarchitecture/src/features/articles/data/data_sources/remote/abstract_article_api.dart';
import 'package:cleanarchitecture/src/features/articles/domain/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/article_response_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/articles_params.dart';
import 'package:dio/dio.dart';

// 추상 클래스를 실제로 구현하여, API에서 데이터를 가져오는 로직
class ArticlesImplApi extends AbstractArticleApi {
  final Dio dio;

  CancelToken cancelToken = CancelToken();

  ArticlesImplApi(this.dio);

  @override
  Future<ApiResponse<List<ArticleModel>>> getArticles(
    ArticlesParams params,
  ) async {
    try {
      final result = (await dio.get(getArticlesPath(params.period)));
    } 
  }
}

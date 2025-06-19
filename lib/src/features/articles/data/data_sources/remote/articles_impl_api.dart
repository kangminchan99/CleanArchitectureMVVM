import 'package:cleanarchitecture/src/core/network/error/dio_error_handler.dart';
import 'package:cleanarchitecture/src/core/network/error/exceptions.dart';
import 'package:cleanarchitecture/src/core/utils/constant/network_constant.dart';
import 'package:cleanarchitecture/src/features/articles/data/data_sources/remote/abstract_article_api.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_response_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart';
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

      if (result.data == null) {
        throw ServerException('unknown error', result.statusCode);
      }
      return ApiResponse.fromJson<List<ArticleModel>>(
        result.data,
        ArticleModel.fromJsonList,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}

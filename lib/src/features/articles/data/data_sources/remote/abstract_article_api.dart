import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_response_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart';

// 추상 API 응답 클래스
abstract class AbstractArticleApi {
  // 모든 기사 가져오기
  Future<ApiResponse<List<ArticleModel>>> getArticles(ArticlesParams params);
}

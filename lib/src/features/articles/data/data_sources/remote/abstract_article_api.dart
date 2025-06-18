import 'package:cleanarchitecture/src/features/articles/domain/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/article_response_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/articles_params.dart';

// 추상 API 응답 클래스
abstract class AbstractArticleApi {
  // 모든 기사 가져오기
  Future<ApiResponse<List<ArticleModel>>> getAllArticles(ArticlesParams params);
}

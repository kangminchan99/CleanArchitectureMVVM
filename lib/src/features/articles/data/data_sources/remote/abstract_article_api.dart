import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_response_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart';

// 모델 파일을 만든 뒤 기사 데이터를 가져오기 위한 api
// 추상 API 응답 클래스
abstract class AbstractArticleApi {
  // 모든 기사 가져오기
  Future<ApiResponse<List<ArticleModel>>> getArticles(ArticlesParams params);
}

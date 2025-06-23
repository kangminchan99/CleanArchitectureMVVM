import 'package:cleanarchitecture/src/core/network/error/failures.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart';
import 'package:dartz/dartz.dart';

// 애플리케이션의 핵심 기능을 구현하기 위해, 데이터 레이어에서 모델과 데이터 소스를 만든 후, 그 데이터 소스를 사용하는 리포지토리 인터페이스와 구현을 만들어야 한다
abstract class AbstractArticlesRepository {
  // get articles
  Future<Either<Failure, List<ArticleModel>>> getArticles(
    ArticlesParams params,
  );
}

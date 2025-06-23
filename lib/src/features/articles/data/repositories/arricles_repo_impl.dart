import 'package:cleanarchitecture/src/core/network/error/exceptions.dart';
import 'package:cleanarchitecture/src/core/network/error/failures.dart';
import 'package:cleanarchitecture/src/features/articles/data/data_sources/remote/articles_impl_api.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart';
import 'package:cleanarchitecture/src/features/articles/domain/repositories/abstract_articles_repository.dart';
import 'package:dartz/dartz.dart';

// repository를 참조하여 실제로 기사 데이터를 가져오는 구현체 (데이터 레이어와 도메인 레이어 연결 부분)
class ArticlesRepositoryImpl extends AbstractArticlesRepository {
  final ArticlesImplApi articlesApi;

  ArticlesRepositoryImpl(this.articlesApi);

  // 기사 가져오기
  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles(
    ArticlesParams params,
  ) async {
    try {
      final result = await articlesApi.getArticles(params);
      return Right(result.results);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}

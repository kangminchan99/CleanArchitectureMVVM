import 'package:cleanarchitecture/src/core/network/error/exceptions.dart';
import 'package:cleanarchitecture/src/core/network/error/failures.dart';
import 'package:cleanarchitecture/src/features/articles/data/data_sources/remote/articles_impl_api.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart';
import 'package:cleanarchitecture/src/features/articles/domain/repositories/abstract_articles_repository.dart';
import 'package:dartz/dartz.dart';

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

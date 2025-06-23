import 'package:cleanarchitecture/src/core/network/error/failures.dart';
import 'package:cleanarchitecture/src/core/utils/usecases/usecase.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart';
import 'package:cleanarchitecture/src/features/articles/domain/repositories/abstract_articles_repository.dart';
import 'package:dartz/dartz.dart';

// 기사 목록을 가져오는 유스케이스 (Use Case는 프레젠테이션과 리포지토리 사이를 잇는 도메인 계층의 핵심 로직)
class ArticlesUsecase extends Usecase<List<ArticleModel>, ArticlesParams> {
  final AbstractArticlesRepository repository;

  ArticlesUsecase(this.repository);

  @override
  Future<Either<Failure, List<ArticleModel>>> call(
    ArticlesParams params,
  ) async {
    final result = await repository.getArticles(params);
    return result.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        return Right(r);
      },
    );
  }
}

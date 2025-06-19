import 'package:cleanarchitecture/src/core/network/error/failures.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/domain/models/articles_params.dart';
import 'package:dartz/dartz.dart';

abstract class AbstractArticlesRepository {
  // get articles
  Future<Either<Failure, List<ArticleModel>>> getArticles(
    ArticlesParams params,
  );
}

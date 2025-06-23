import 'package:cleanarchitecture/src/core/network/dio_network.dart';
import 'package:cleanarchitecture/src/core/utils/injections.dart';
import 'package:cleanarchitecture/src/features/articles/data/data_sources/local/articles_shared_prefs.dart';
import 'package:cleanarchitecture/src/features/articles/data/data_sources/remote/articles_impl_api.dart';
import 'package:cleanarchitecture/src/features/articles/data/repositories/arricles_repo_impl.dart';
import 'package:cleanarchitecture/src/features/articles/domain/repositories/abstract_articles_repository.dart';
import 'package:cleanarchitecture/src/features/articles/domain/usecases/articles_usecase.dart';

initArticlesInjections() {
  // Article 관련 의존성 주입 설정
  // registerSingleton - 지금 바로 생성해서 컨테이너에 고정 보관
  sl.registerSingleton<ArticlesImplApi>(ArticlesImplApi(DioNetwork.appAPI));
  // <안에 있는걸로 꺼내올 수 있음> - ArticlesImplApi를 사용하여 ArticlesRepositoryImpl을 생성
  // 의존성 역전 - DIP
  sl.registerSingleton<AbstractArticlesRepository>(
    ArticlesRepositoryImpl(sl()),
  );
  sl.registerSingleton<ArticlesSharedPrefs>(ArticlesSharedPrefs(sl()));

  sl.registerSingleton<ArticlesUsecase>(ArticlesUsecase(sl()));
}

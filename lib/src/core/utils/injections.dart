import 'package:cleanarchitecture/src/core/network/dio_network.dart';
import 'package:cleanarchitecture/src/core/utils/log/app_logger.dart';
import 'package:cleanarchitecture/src/features/articles/articles_injections.dart';
import 'package:cleanarchitecture/src/shared/app_injections.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await initAppInjections();
  await initDioInjections();
  await initArticlesInjections();
}

// SharedPreferences 먼저 sl에 등록하고 initAppInjections에서 주입
initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}

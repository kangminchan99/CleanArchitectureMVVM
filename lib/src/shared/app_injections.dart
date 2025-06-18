import 'package:cleanarchitecture/src/core/utils/injections.dart';
import 'package:cleanarchitecture/src/shared/data/data_sources/app_shared_prefs.dart';

initAppInjections() {
  // registerFactory - 요청할 때마다 새로운 인스턴스를 생성해서 제공
  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));
}

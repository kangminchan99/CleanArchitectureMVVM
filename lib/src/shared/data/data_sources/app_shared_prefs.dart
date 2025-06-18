import 'package:cleanarchitecture/src/shared/domain/entities/language_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/constant/local_storage_constant.dart';

class AppSharedPrefs {
  final SharedPreferences _preferences;

  AppSharedPrefs(this._preferences);

  // 저장된 언어 값을 가져옴 (없으면 영어)
  LanguageEnum? getLang() {
    String? data = _preferences.getString(lang);
    if (data == null) {
      return LanguageEnum.en;
    }
    return LanguageEnum.values.firstWhere((element) => element.local == data);
  }

  // 언어 설정 값을 저장
  void setLang(LanguageEnum language) {
    _preferences.setString(lang, language.local);
  }

  // 다크 테마 상태 가져오기
  bool getIsDarkTheme() {
    return _preferences.getBool(theme) ?? false;
  }

  // 다크 테마 상태 저장
  void setDarkTheme(bool isDark) {
    _preferences.setBool(theme, isDark);
  }
}

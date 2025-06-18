import 'package:cleanarchitecture/main.dart';
import 'package:cleanarchitecture/src/core/translations/l10n.dart';

enum LanguageEnum {
  ar, // Arabic
  en, // English
}

extension LanguageEnumExtension on LanguageEnum {
  String get local {
    switch (this) {
      case LanguageEnum.ar:
        return 'ar';
      case LanguageEnum.en:
        return 'en';
    }
  }

  String get localeHeader {
    switch (this) {
      case LanguageEnum.ar:
        return 'ar_AE';
      case LanguageEnum.en:
        return 'en-US';
    }
  }

  String get langName {
    switch (this) {
      case LanguageEnum.ar:
        return S.of(navigatorKey.currentContext!).arabic;

      case LanguageEnum.en:
        return S.of(navigatorKey.currentContext!).english;
    }
  }
}

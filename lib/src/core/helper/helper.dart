import 'package:cleanarchitecture/src/core/utils/constant/app_constant.dart';
import 'package:cleanarchitecture/src/core/utils/injections.dart';
import 'package:cleanarchitecture/src/shared/data/data_sources/app_shared_prefs.dart';
import 'package:cleanarchitecture/src/shared/domain/entities/language_enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 초기 고정 세팅 값
class Helper {
  // get language
  static LanguageEnum getLang() {
    LanguageEnum? lang;
    lang = sl<AppSharedPrefs>().getLang();
    lang = lang ?? LanguageEnum.en;
    return lang;
  }

  // get svg img path
  static String getSvgPath(String name) {
    return '$svgPath$name';
  }

  // get img path
  static String getImgPath(String name) {
    return '$imagePath$name';
  }

  // get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  // get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  // get dio header
  static Map<String, dynamic> getHeaders() {
    // 헤더가 없으므로 {}로 초기화
    return {}..removeWhere((key, value) => value == null);
  }

  // check if dark theme is enabled
  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }
}

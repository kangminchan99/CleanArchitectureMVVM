import 'package:shared_preferences/shared_preferences.dart';

class ArticlesSharedPrefs {
  final SharedPreferences _preferences;

  ArticlesSharedPrefs(this._preferences);

  // clear storage
  Future<bool> clearAllLocalData() async {
    return true;
  }
}

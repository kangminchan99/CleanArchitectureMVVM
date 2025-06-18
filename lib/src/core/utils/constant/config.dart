import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get articleApiKey => dotenv.env['ARTICLE_API_KEY'] ?? '';
  static String get articleApiUrl => dotenv.env['ARTICLE_API_URL'] ?? '';
}

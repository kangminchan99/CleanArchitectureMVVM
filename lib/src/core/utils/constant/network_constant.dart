import 'package:cleanarchitecture/src/core/utils/constant/config.dart';

// API 경로
String apiUrl = '${Config.articleApiUrl}/mostviewed/';
String apiKey = Config.articleApiKey;

String getApiKeyPath() {
  return '?api-key=$apiKey';
}

String getArticlesPath(int period) {
  return 'all-sections/${period.toString()}.json${getApiKeyPath()}';
}

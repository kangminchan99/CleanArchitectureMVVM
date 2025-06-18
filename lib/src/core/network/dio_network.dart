import 'package:dio/dio.dart';

class DioNetwork {
  static late Dio appAPI;
  static late Dio retryAPI;

  static void initDio() {
    appAPI = Dio(baseOptions)
  }


  static BaseOptions baseOptions(String url) {
    Map<String, dynamic> headers = Help
  }
}

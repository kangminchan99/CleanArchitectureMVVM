// 초기 고정 세팅 값
import 'dart:convert';

import 'package:cleanarchitecture/src/core/helper/helper.dart';
import 'package:cleanarchitecture/src/core/network/logger_interceptor.dart';
import 'package:cleanarchitecture/src/core/utils/constant/network_constant.dart';
import 'package:cleanarchitecture/src/core/utils/log/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// 네트워크 요청을 처리하기 위한 Dio 인스턴스를 관리
class DioNetwork {
  static late Dio appAPI;
  static late Dio retryAPI;

  static void initDio() {
    appAPI = Dio(baseOptions(apiUrl));
    // 요청 및 응답 로깅
    appAPI.interceptors.add(loggerInterceptor());
    // appApI에 대한 큐 인터셉터
    appAPI.interceptors.add(appQueuedInterceptorsWrapper());

    retryAPI = Dio(baseOptions(apiUrl));
    retryAPI.interceptors.add(loggerInterceptor());
    retryAPI.interceptors.add(interceptorsWrapper());
  }

  static LoggerInterceptor loggerInterceptor() {
    return LoggerInterceptor(
      logger,
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: false,
      requestHeader: true,
    );
  }

  ///__________App__________///

  /// App Api Queued Interceptor
  static QueuedInterceptorsWrapper appQueuedInterceptorsWrapper() {
    return QueuedInterceptorsWrapper(
      onRequest: (RequestOptions options, r) async {
        Map<String, dynamic> headers = Helper.getHeaders();

        if (kDebugMode) {
          print("Headers");
          print(json.encode(headers));
        }
        options.headers = headers;
        appAPI.options.headers = headers;
        return r.next(options);
      },
      onError: (error, handler) async {
        try {
          return handler.next(error);
        } catch (e) {
          return handler.reject(error);
          // onUnexpectedError(handler, error);
        }
      },
      onResponse:
          (
            Response<dynamic> response,
            ResponseInterceptorHandler handler,
          ) async {
            return handler.next(response);
          },
    );
  }

  /// App interceptor
  static InterceptorsWrapper interceptorsWrapper() {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, r) async {
        Map<String, dynamic> headers = Helper.getHeaders();

        options.headers = headers;
        appAPI.options.headers = headers;

        return r.next(options);
      },
      onResponse: (response, handler) async {
        if ("${(response.data["code"] ?? "0")}" != "0") {
          return handler.resolve(response);
          // return handler.reject(DioError(requestOptions: response.requestOptions, response: response, error: response, type: DioErrorType.response));
        } else {
          return handler.next(response);
        }
      },
      onError: (error, handler) {
        try {
          return handler.next(error);
        } catch (e) {
          return handler.reject(error);
          // onUnexpectedError(handler, error);
        }
      },
    );
  }

  static BaseOptions baseOptions(String url) {
    Map<String, dynamic> headers = Helper.getHeaders();

    return BaseOptions(
      baseUrl: url,
      validateStatus: (s) {
        return s! < 300;
      },
      headers: headers..removeWhere((key, value) => value == null),
      responseType: ResponseType.json,
    );
  }
}

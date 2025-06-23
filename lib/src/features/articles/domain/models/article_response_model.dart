import 'package:flutter/foundation.dart';

// <T> - Generic type (어떤 타입이든 외부에서 정해서 쓸 수 있다.)
class ApiResponse<T> {
  // 응답 데이터 캡슐화하기 위한 모델 클래스
  ApiResponse({
    required this.status,
    required this.copyright,
    required this.numResults,
    required this.results,
  });

  late final String? status;
  late final String? copyright;
  late final int? numResults;
  late final T results;

  static fromJson<T>(Map<String, dynamic> json, Function tFromJson) {
    return ApiResponse<T>(
      status: json['status'],
      copyright: json['copyright'],
      numResults: json['num_results'],
      // tFromJson 함수 results 필드의 데이터를 반환하는 함수로
      // 예를 들어 ArticleModel로 변환할 수 있다.
      results: tFromJson(json['results']),
    );
  }

  @override
  int get hashCode => Object.hash(status, copyright, numResults, results);

  // 데이터가 같으면 같은 객체로 간주
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    if (other is ApiResponse) {
      return other.results is List
          ? listEquals(other.results, results as List)
          : other.results == results;
    }

    return false;
  }
}

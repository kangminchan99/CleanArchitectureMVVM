import 'package:flutter/foundation.dart';

// <T> - Generic type (어떤 타입이든 외부에서 정해서 쓸 수 있다.)
class ApiResponse<T> {
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
      results: tFromJson(json['results']),
    );
  }

  @override
  int get hashCode => Object.hash(status, copyright, numResults, results);

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

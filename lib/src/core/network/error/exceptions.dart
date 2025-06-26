// 초기 고정 세팅 값
// 서버 오류가 발생했을 때 발생하는 예외 처리
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, this.statusCode);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is ServerException) {
      return other.message == message && other.statusCode == statusCode;
    }

    return false;
  }

  // 해시코드 정의
  @override
  int get hashCode => Object.hash(message, statusCode);
}

// API 호출 시간 제한을 초과했을 때 발생하는 예외 처리
class CancelTokenException implements Exception {
  final String message;
  final int? statusCode;

  CancelTokenException(this.message, this.statusCode);
}

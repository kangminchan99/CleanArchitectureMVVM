import 'package:cleanarchitecture/src/core/network/error/failures.dart';
import 'package:dartz/dartz.dart';

// usecase - 앱이 제공하는 하나의 기능 또는 행동 단위
abstract class Usecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}

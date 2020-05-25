import 'package:cardiompp/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<bool> call(Params params);
  // Future<Either<Failure, bool>> call(Params params);
}
import 'package:cardiompp/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<bool> authenticationAPI(String email, String password);
  // Future<Either<Failure, bool>> authenticationAPI(String email, String password);
}
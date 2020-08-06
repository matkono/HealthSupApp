import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Doctor>> authenticationAPI(String email, String password);
}
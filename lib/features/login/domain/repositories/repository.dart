import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, Doctor>> loginUser(String email, String password);
}
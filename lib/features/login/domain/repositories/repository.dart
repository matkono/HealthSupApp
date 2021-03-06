import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/login/domain/entities/doctor.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, Doctor>> loginUser(String email, String password);
  Future<Either<Failure, bool>> updatePassword(String email, String password,
      String newPassword, String confirmNewPassword);
}

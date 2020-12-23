import 'package:HealthSup/core/error/exception.dart';
import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/core/usecase/usecase.dart';
import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:HealthSup/features/login/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class LoginUser implements UseCase<Doctor, ParamsLogin> {
  final LoginRepository loginRepository;

  LoginUser(
    this.loginRepository,
  );

  @override
  Future<Either<Failure, Doctor>> call(ParamsLogin params) async {
    try {
      final loginResult =
          await loginRepository.loginUser(params.email, params.password);

      return loginResult;
    } on Exception catch (_) {
      throw ServerException();
    }
  }
}

class ParamsLogin extends Equatable {
  final String email;
  final String password;

  ParamsLogin({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

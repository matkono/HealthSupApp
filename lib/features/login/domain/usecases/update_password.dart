import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/login/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class UpdatePassword implements UseCase<bool, ParamsUpdatePassword> {
  final LoginRepository loginRepository;

  UpdatePassword(
    this.loginRepository,
  );

  @override
  Future<Either<Failure, bool>> call(ParamsUpdatePassword params) async {
    try {
      final loginResult = await loginRepository.updatePassword(params.email,
          params.password, params.newPassword, params.confirmNewPassword);

      return loginResult;
    } on Exception catch (_) {
      throw ServerException();
    }
  }
}

class ParamsUpdatePassword extends Equatable {
  final String email;
  final String password;
  final String newPassword;
  final String confirmNewPassword;

  ParamsUpdatePassword({
    @required this.email,
    @required this.password,
    @required this.newPassword,
    @required this.confirmNewPassword,
  });

  @override
  List<Object> get props => [email, password, newPassword, confirmNewPassword];
}

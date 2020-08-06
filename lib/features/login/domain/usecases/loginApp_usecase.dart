import 'package:HealthSup/core/error/exception.dart';
import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/core/usecase/usecase.dart';
import 'package:HealthSup/features/login/data/repositories/repository_impl.dart';
import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class LoginAppUseCase implements UseCase<Doctor, Params> {
  final doctorRepository = new DoctorRepositoryImpl();

  @override
  Future<Either<Failure, Doctor>> call(Params params) async {
    try {
      final loginResult = await doctorRepository.authenticationAPI(
          params.email, params.password);

      return loginResult;
      
    } on Exception catch (_) {
      throw ServerException();
    }
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

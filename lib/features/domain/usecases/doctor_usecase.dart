import 'package:cardiompp/core/usecase/usecase.dart';
import 'package:cardiompp/features/data/repositories/repository_impl.dart';
import 'package:cardiompp/features/domain/entities/doctor.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


// UseCases's Class

class DoctorUseCase implements UseCase<Doctor, Params> {

  @override
  Future<bool> call(Params params) async {
    final doctorRepository = new DoctorRepositoryImpl();
    return await doctorRepository.authenticationAPI(params.email, params.password);
  }

  // @override
  // Future<Either<Failure, bool>> call(Params params) async {
  //   final doctorRepository = new DoctorRepositoryImpl();
  //   return await doctorRepository.authenticationAPI(params.email, params.password);
  // }
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

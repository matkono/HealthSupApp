import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:mobilecache/core/usecase/usecase.dart';
import 'package:mobilecache/features/data/repositories/doctor_repository_impl.dart';
import 'package:mobilecache/features/domain/entities/doctor.dart';

// UseCases's Class

class GetDoctorLogin implements UseCase<Doctor, Params> {

  @override
  Future<bool> call(Params params) async {
    final doctorRepository = new DoctorRepositoryImpl();
    return await doctorRepository.getLoginDataFromRepository(params.crm, params.email, params.password);
  }
}

class Params extends Equatable {
  final String crm;
  final String email;
  final String password;
  
  Params({
    @required this.crm,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [crm, email, password];
}

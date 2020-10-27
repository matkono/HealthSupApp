import 'package:HealthSup/core/error/exception.dart';
import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/core/usecase/usecase.dart';
import 'package:HealthSup/features/patient/domain/entities/patient.dart';
import 'package:dartz/dartz.dart';

class ListPatient extends UseCase<Patient, NoParams> {
  // final patientRepository = new PatientRepositoryImpl();

  @override
  Future<Either<Failure, Patient>> call(NoParams params) async {
    try {
      // final patientList = await patientRepository.getPatientList();
      // return patientList;
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}

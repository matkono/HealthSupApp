import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
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

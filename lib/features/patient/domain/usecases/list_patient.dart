import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:dartz/dartz.dart';
import 'package:healthsup/features/patient/domain/repositories/patient_repository.dart';

class ListPatient extends UseCase<Patient, NoParams> {
  final PatientRepository patientRepository;

  ListPatient(
    this.patientRepository,
  );

  @override
  Future<Either<Failure, Patient>> call(NoParams params) async {
    return await patientRepository.getPatientList();
  }
}

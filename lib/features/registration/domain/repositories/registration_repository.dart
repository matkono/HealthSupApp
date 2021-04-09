import 'package:healthsup/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, RegisterPatientEntity>> registerPatient(String name,
      String registration, String neighborhood, String cep, String city);
  Future<Either<Failure, RegisterPatientEntity>> viaCep(
      RegisterPatientEntity registerPatient);
  Future<Either<Failure, RegisterPatientEntity>> updatePatient(
      int patientID, CepInfo address);
}

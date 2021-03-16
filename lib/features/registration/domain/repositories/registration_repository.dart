import 'package:healthsup/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, RegisterPatientEntity>> registerPatient(
      RegisterPatientEntity registerPatient);
  Future<Either<Failure, RegisterPatientEntity>> viaCep(
      RegisterPatientEntity registerPatient);
}

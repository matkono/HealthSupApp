import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/features/patient/domain/entities/patient.dart';
import 'package:dartz/dartz.dart';

abstract class DecisionTreeRepository {
  Future<Either<Failure, Patient>> getPatientList();
  Future<Either<Failure, Patient>> registerPatient(Patient patient);
  Future<Either<Failure, Patient>> searchPatient(Patient patient);
}
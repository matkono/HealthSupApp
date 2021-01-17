import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthsup/features/patient/domain/repositories/patient_repository.dart';

class RegisterPatient extends UseCase<Patient, PatientParams> {
  final PatientRepository patientRepository;

  RegisterPatient(
    this.patientRepository,
  );

  @override
  Future<Either<Failure, Patient>> call(PatientParams params) async {
    return await patientRepository.registerPatient(params.patient);
  }
}

class PatientParams extends Equatable {
  final Patient patient;

  PatientParams({
    @required this.patient,
  });

  @override
  List<Object> get props => [patient];
}

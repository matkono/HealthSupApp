import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/patient/domain/repositories/patient_repository.dart';

class ViaCep extends UseCase<Patient, CepParams> {
  final PatientRepository patientRepository;

  ViaCep(
    this.patientRepository,
  );

  @override
  Future<Either<Failure, Patient>> call(CepParams params) async {
    return await patientRepository.viaCep(params.patient);
  }
}

class CepParams extends Equatable {
  final Patient patient;

  CepParams({
    @required this.patient,
  });

  @override
  List<Object> get props => [patient];
}

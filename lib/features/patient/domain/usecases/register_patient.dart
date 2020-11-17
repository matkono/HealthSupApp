import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/core/usecase/usecase.dart';
import 'package:HealthSup/features/patient/domain/entities/patient.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RegisterPatient extends UseCase<Patient, PatientParams> {
  // final patientRepository = new PatientRepositoryImpl();
  
    @override
    Future<Either<Failure, Patient>> call(PatientParams params) async {
      // return await patientRepository.registerPatient(params.patient);
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
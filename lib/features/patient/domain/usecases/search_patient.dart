import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SearchPatient extends UseCase<Patient, PatientParams> {
  // final patientRepository = new PatientRepositoryImpl();

  @override
  Future<Either<Failure, Patient>> call(PatientParams params) async {
    try {
      // final searchPatient = await patientRepository.searchPatient(params.registration);
      // return searchPatient;
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}

class PatientParams extends Equatable {
  final String registration;

  PatientParams({
    @required this.registration,
  });

  @override
  List<Object> get props => [registration];
}

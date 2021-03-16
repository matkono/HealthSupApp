import 'package:flutter/material.dart';
import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/features/patient/data/datasources/patient_remote_datasource_impl.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:healthsup/features/patient/domain/repositories/patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource patientRemoteDataSource;

  PatientRepositoryImpl({
    @required this.patientRemoteDataSource,
  });

  @override
  Future<Either<Failure, Patient>> getPatientList() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Patient>> registerPatient(Patient patient) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Patient>> searchPatient(String registration) async {
    try {
      final patient = await patientRemoteDataSource.searchPatient(registration);
      return Right(patient);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}

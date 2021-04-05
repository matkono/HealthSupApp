import 'package:flutter/material.dart';
import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:healthsup/features/registration/data/datasources/register_remote_datasource.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/domain/repositories/registration_repository.dart';

class RegistrationRepositoryImpl extends RegistrationRepository {
  final RegisterRemoteDataSource registerRemoteDataSource;

  RegistrationRepositoryImpl({
    @required this.registerRemoteDataSource,
  });
  @override
  Future<Either<Failure, RegisterPatientEntity>> registerPatient(
      RegisterPatientEntity registerPatient) async {
    try {
      final registration =
          await registerRemoteDataSource.registerPatient(registerPatient);
      return Right(registration);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterPatientEntity>> viaCep(
      RegisterPatientEntity registerPatient) async {
    try {
      if (registerPatient.cepInfo == null ||
          registerPatient.cepInfo.cep == null) {
        return Left(ZipCodeFailure());
      }
      final cepInfo =
          await registerRemoteDataSource.viaCep(registerPatient.cepInfo.cep);
      RegisterPatientEntity patientResult = registerPatient;
      patientResult.cepInfo = cepInfo;
      return Right(patientResult);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } on ZipCodeException catch (_) {
      return Left(ZipCodeFailure());
    }
  }
}

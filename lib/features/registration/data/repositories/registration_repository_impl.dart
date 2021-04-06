import 'package:flutter/material.dart';
import 'package:healthsup/core/error/exception.dart';
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
  Future<Either<Failure, RegisterPatientEntity>> registerPatient(String name,
      String registration, String neighborhood, String cep, String city) async {
    try {
      final registrationResponse = await registerRemoteDataSource
          .registerPatient(name, registration, neighborhood, cep, city);
      return Right(registrationResponse);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterPatientEntity>> viaCep(
      RegisterPatientEntity registerPatient) async {
    try {
      if (registerPatient.address == null ||
          registerPatient.address.cep == null) {
        return Left(ZipCodeFailure());
      }
      final cepInfo =
          await registerRemoteDataSource.viaCep(registerPatient.address.cep);
      RegisterPatientEntity patientResult = registerPatient;
      patientResult.address = cepInfo;
      return Right(patientResult);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } on ZipCodeException catch (_) {
      return Left(ZipCodeFailure());
    }
  }
}

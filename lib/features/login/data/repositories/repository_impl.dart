import 'dart:async';
import 'dart:io';

import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/features/login/data/datasources/local_datasource.dart';
import 'package:HealthSup/features/login/data/datasources/remote_datasource.dart';
import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:HealthSup/features/login/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  LoginRepositoryImpl({
    @required this.loginRemoteDataSource,
    @required this.loginLocalDataSource,
  });

  @override
  Future<Either<Failure, Doctor>> loginUser(
      String email, String password) async {
    bool connectivity = await DataConnectionChecker().hasConnection;

    if (connectivity == false) {
      return Left(NoInternetConnectionFailure());
    } else {
      try {
        final fromDoctorModel =
            await loginRemoteDataSource.getLoginUser(email, password);
        final toDoctor = new Doctor(
            crm: fromDoctorModel.crm,
            email: fromDoctorModel.email,
            isActive: fromDoctorModel.isActive);
        return Right(toDoctor);
      } on TimeoutException catch (e) {
        print(e);
        return Left(ServerFailure(failureMessage: 'Connection timeout'));
      } on SocketException catch (e) {
        print(e);
        return Left(ServerFailure(failureMessage: 'Connection timeout'));
      } on Exception catch (e) {
        print(e);
        return Left(ServerFailure(failureMessage: "Email ou Senha inválidos"));
      }
    }
  }
}

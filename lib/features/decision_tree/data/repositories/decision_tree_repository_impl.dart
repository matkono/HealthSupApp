import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/decision_tree/data/datasources/local_datasource_impl.dart';
import 'package:healthsup/features/decision_tree/data/datasources/remote_datasource_impl.dart';
import 'package:healthsup/features/decision_tree/data/models/answer_model.dart';
import 'package:healthsup/features/decision_tree/domain/entities/answer.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class DecisionTreeRepositoryImpl implements DecisionTreeRepository {
  final DecisionTreeRemoteDataSource remoteDataSource;
  final DecisionTreeLocalDataSource localDataSource;

  DecisionTreeRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, MedicalAppointment>> startMedicalAppointment(
      int patientId, int diseaseId) async {
    try {
      final startNode = await remoteDataSource.startNodeMedicalAppointment(
          patientId, diseaseId);
      return Right(startNode);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Node>> sendAnswer(Answer answer) async {
    try {
      final fromEntity = AnswerModel.fromEntity(answer);
      final sendNode = await remoteDataSource.setAnswer(fromEntity);
      return Right(sendNode);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Node>> previousQuestion(
      int idAppointment, int idCurrentNode) async {
    try {
      final node = await remoteDataSource.getPreviousQuestion(
          idAppointment, idCurrentNode);
      return Right(node);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> finishAppointment(
      int idAppointment, bool finished) async {
    try {
      return Right(
          await remoteDataSource.finishAppointment(idAppointment, finished));
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Node>> getCurrentNode(int idAppointment) async {
    try {
      final node = await remoteDataSource.getCurrentNode(idAppointment);
      return Right(node);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Node>> confirmAction(
      int idAction, int idAppointment) async {
    try {
      final node =
          await remoteDataSource.confirmAction(idAction, idAppointment);
      return Right(node);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}

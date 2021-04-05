import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:dartz/dartz.dart';
import 'package:healthsup/features/decision_tree/domain/repositories/decision_tree_repository.dart';

class StartNewDisease
    extends UseCase<MedicalAppointment, ParamsStartNewDisease> {
  final DecisionTreeRepository decisionTreeRepository;

  StartNewDisease(
    this.decisionTreeRepository,
  );

  @override
  Future<Either<Failure, MedicalAppointment>> call(
      ParamsStartNewDisease params) async {
    try {
      final nodeType = await decisionTreeRepository.startMedicalAppointment(
          params.patientId, params.diseaseId);
      return nodeType;
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}

class ParamsStartNewDisease extends Equatable {
  final int patientId;
  final int diseaseId;

  ParamsStartNewDisease({
    @required this.patientId,
    @required this.diseaseId,
  });

  @override
  List<Object> get props => [patientId, diseaseId];
}

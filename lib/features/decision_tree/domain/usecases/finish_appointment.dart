import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/core/usecase/usecase.dart';
import 'package:HealthSup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class FinishAppointment extends UseCase<void, ParamsFinishAppointment> {
  final DecisionTreeRepository treeRepository;

  FinishAppointment(
    this.treeRepository,
  );

  @override
  Future<Either<Failure, void>> call(ParamsFinishAppointment params) async {
    return await treeRepository.finishAppointment(params.medicalAppointmentId, params.finished);
  }
}

class ParamsFinishAppointment extends Equatable {
  final int medicalAppointmentId;
  final bool finished;

  ParamsFinishAppointment({
    @required this.medicalAppointmentId,
    @required this.finished,
  });

  @override
  List<Object> get props => [medicalAppointmentId, finished];
}

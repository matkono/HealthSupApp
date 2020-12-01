import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/core/usecase/usecase.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:HealthSup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ConfirmAction extends UseCase<Node, ParamsConfirmAction> {
  final DecisionTreeRepository treeRepository;

  ConfirmAction(
    this.treeRepository,
  );

  @override
  Future<Either<Failure, Node>> call(ParamsConfirmAction params) async {
    return await treeRepository.confirmAction(params.idAction, params.idAppointment);
  }
}

class ParamsConfirmAction extends Equatable {
  final int idAction;
  final int idAppointment;

  ParamsConfirmAction({
    @required this.idAction,
    @required this.idAppointment,
  });

  @override
  List<Object> get props => [idAction, idAppointment];
}

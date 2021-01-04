import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PreviousQuestion extends UseCase<Node, ParamsPreviousNode> {
  final DecisionTreeRepository treeRepository;

  PreviousQuestion(
    this.treeRepository,
  );

  @override
  Future<Either<Failure, Node>> call(ParamsPreviousNode params) async {
    return await treeRepository.previousQuestion(
        params.idAppointment, params.idCurrentNode);
  }
}

class ParamsPreviousNode extends Equatable {
  final int idAppointment;
  final int idCurrentNode;

  ParamsPreviousNode({
    @required this.idAppointment,
    @required this.idCurrentNode,
  });

  @override
  List<Object> get props => [idAppointment, idCurrentNode];
}

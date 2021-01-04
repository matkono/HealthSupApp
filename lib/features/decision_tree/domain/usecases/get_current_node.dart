import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetCurrentNode extends UseCase<Node, ParamsCurrentNode> {
  final DecisionTreeRepository treeRepository;

  GetCurrentNode(
    this.treeRepository,
  );

  @override
  Future<Either<Failure, Node>> call(ParamsCurrentNode params) async {
    return await treeRepository.getCurrentNode(params.idAppointment);
  }
}

class ParamsCurrentNode extends Equatable {
  final int idAppointment;

  ParamsCurrentNode({
    @required this.idAppointment,
  });

  @override
  List<Object> get props => [idAppointment];
}

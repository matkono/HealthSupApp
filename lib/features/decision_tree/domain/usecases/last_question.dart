import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/core/usecase/usecase.dart';
import 'package:HealthSup/features/decision_tree/data/repositories/decision_tree_repository_impl.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class LastQuestion extends UseCase<Node, ParamsQuestion> {
  final treeRepository = new DecisionTreeRepositoryImpl();

  @override
  Future<Either<Failure, Node>> call(ParamsQuestion params) async {
    return await treeRepository.lastQuestion(params.idQuestion);
  }
}

class ParamsQuestion extends Equatable {
  final int idQuestion;

  ParamsQuestion({
    @required this.idQuestion,
  });

  @override
  List<Object> get props => [idQuestion];
}

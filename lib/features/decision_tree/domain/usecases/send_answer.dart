import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/decision_tree/domain/entities/answer.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class SendAnswer extends UseCase<Node, ParamsAnswer> {
  final DecisionTreeRepository decisionTreeRepositoryImpl;

  SendAnswer(
    this.decisionTreeRepositoryImpl,
  );

  @override
  Future<Either<Failure, Node>> call(ParamsAnswer params) async {
    return await decisionTreeRepositoryImpl.sendAnswer(params.answer);
  }
}

class ParamsAnswer extends Equatable {
  final Answer answer;

  ParamsAnswer({
    @required this.answer,
  });

  @override
  List<Object> get props => [answer];
}

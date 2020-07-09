import 'package:cardiompp/core/error/failure.dart';
import 'package:cardiompp/core/usecase/usecase.dart';
import 'package:cardiompp/features/decision_tree/data/repositories/decision_tree_repository_impl.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/node.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class SendAnswer extends UseCase<Node, ParamsAnswer> {
  final decisionTreeRepositoryImpl = new DecisionTreeRepositoryImpl();

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

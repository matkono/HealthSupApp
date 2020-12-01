import 'package:HealthSup/features/decision_tree/domain/entities/decision_tree.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node_type.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/question_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Node extends Equatable {
  final int questionId;
  final int code;
  final String title;
  final QuestionType questionType;
  final List<PossibleAnswer> possibleAnswers;
  final int id;
  final bool isInitial;
  final NodeType nodeType;
  final DecisionTree decisionTree;

  Node({
    @required this.questionId,
    @required this.code,
    @required this.title,
    @required this.questionType,
    @required this.possibleAnswers,
    @required this.id,
    @required this.isInitial,
    @required this.nodeType,
    @required this.decisionTree,
  });

  @override
  List<Object> get props => [
        questionId,
        code,
        title,
        questionType,
        possibleAnswers,
        id,
        isInitial,
        nodeType,
        decisionTree,
      ];
}

import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/question_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Question extends Equatable {
  final int id;
  final int code;
  final String title;
  final QuestionType questionType;
  final List<PossibleAnswer> possibleAnswers;

  Question({
    @required this.id,
    @required this.code,
    @required this.title,
    @required this.questionType,
    @required this.possibleAnswers,
  });

  @override
  List<Object> get props => [id, code, title, questionType, possibleAnswers];
}

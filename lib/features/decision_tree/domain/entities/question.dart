import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Question extends Equatable {
  final int questionCode;
  final String title;
  final List<PossibleAnswer> possibleAnswers;
  final int questionTypeCode;

  Question({
    @required this.questionCode,
    @required this.title,
    @required this.possibleAnswers,
    @required this.questionTypeCode,
    });

  @override
  List<Object> get props => [questionCode, title, possibleAnswers, questionTypeCode];
}
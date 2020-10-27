import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer_group.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PossibleAnswer extends Equatable {
  final int id;
  final int code;
  final String title;
  final PossibleAnswerGroup possibleAnswerGroup;

  PossibleAnswer({
    @required this.id,
    @required this.code,
    @required this.title,
    @required this.possibleAnswerGroup,
  });

  @override
  List<Object> get props => [id, code, title, possibleAnswerGroup];
}

import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Answer extends Equatable {
  final List<PossibleAnswer> answers;

  Answer({
    @required this.answers,
  });

  @override
  List<Object> get props => [answers];
}
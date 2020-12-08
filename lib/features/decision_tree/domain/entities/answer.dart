import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Answer extends Equatable {
  final int medicalAppointmentId;
  final int doctorId;
  final int questionId;
  final int possibleAnswerGroupId;
  final DateTime date;
  final List<PossibleAnswer> possibleAnswers;

  Answer({
    @required this.medicalAppointmentId,
    @required this.doctorId,
    @required this.questionId,
    @required this.possibleAnswerGroupId,
    @required this.date,
    @required this.possibleAnswers,
  });

  @override
  List<Object> get props => [possibleAnswers];
}

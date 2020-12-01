import 'package:HealthSup/features/decision_tree/data/models/possible_answer_model.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/answer.dart';
import 'package:flutter/foundation.dart';

class AnswerModel extends Answer {
  AnswerModel({
    @required medicalAppointmentId,
    @required doctorId,
    @required questionId,
    @required possibleAnswerGroupId,
    @required date,
    @required possibleAnswers,
  }) : super(
          medicalAppointmentId: medicalAppointmentId,
          doctorId: doctorId,
          questionId: questionId,
          possibleAnswerGroupId: possibleAnswerGroupId,
          date: date,
          possibleAnswers: possibleAnswers,
        );

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return AnswerModel(
      medicalAppointmentId: json['medicalAppointmentId'],
      doctorId: json['doctorId'],
      questionId: json['questionId'],
      possibleAnswerGroupId: json['possibleAnswerGroupId'],
      date: json['date'],
      possibleAnswers: json['possibleAnswers'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (medicalAppointmentId != null)
      json['medicalAppointmentId'] = medicalAppointmentId;
    if (doctorId != null)
      json['doctorId'] = doctorId;
    if (questionId != null)
      json['questionId'] = questionId;
    if (possibleAnswerGroupId != null)
      json['possibleAnswerGroupId'] = possibleAnswerGroupId;
    if (date != null)
      json['date'] = date;
    if (possibleAnswers != null)
      json['possibleAnswers'] = possibleAnswers;

    return json;
  }

  factory AnswerModel.fromEntity(Answer answer) {
    if (answer == null) return null;

    return AnswerModel(
      medicalAppointmentId: answer.medicalAppointmentId,
      doctorId: answer.doctorId,
      questionId: answer.questionId,
      possibleAnswerGroupId: answer.possibleAnswerGroupId,
      date: answer.date,
      possibleAnswers: answer.possibleAnswers,
    );
  }

  static List<dynamic> listToJson(List<PossibleAnswerModel> list) {
    if (list == null) return null;

    List<dynamic> json = [];

    for (PossibleAnswerModel i in list) {
      json.add(i.toJson());
    }

    return json;
  }

  static List<PossibleAnswerModel> listFromJson(List<dynamic> json) {
    if (json == null) return null;

    List<PossibleAnswerModel> list = [];

    for (dynamic i in json) {
      list.add(i);
    }

    return list;
  }
}

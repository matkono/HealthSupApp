import 'package:HealthSup/features/decision_tree/data/models/possible_answer_model.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/answer.dart';
import 'package:flutter/foundation.dart';

class AnswerModel extends Answer {
  AnswerModel({
    @required List<PossibleAnswerModel> answers,

  }) : super(answers: answers);

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return AnswerModel(
      answers: json['Answers'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (answers != null) json['Answers'] = answers;

    return json;
  }

  factory AnswerModel.fromEntity(Answer answer) {
    if (answer == null) return null;

    return AnswerModel(
      answers: AnswerModel.listFromJson(answer.answers),
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
      // list.add(PossibleAnswerModel.fromJson(i));
      list.add(i);
    }

    return list;
  }
}

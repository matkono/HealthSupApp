import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:flutter/foundation.dart';

class AnswerModel extends Answer {
  AnswerModel({
    // @required String value,
    // @required int code,
    @required List<Map<String, int>> answers,
  }) : super(answers: answers);

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return AnswerModel(
      // value: json['Value'],
      // code: json['Code'],
      answers: json['Answers'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    // if (value != null) json['Value'] = value;
    // if (code != null) json['Code'] = code;
    if (answers != null) json['Answers'] = answers;

    return json;
  }

  factory AnswerModel.fromEntity(Answer answer) {
    if (answer == null) return null;

    return AnswerModel(
      // value: answer.value,
      // code: answer.code,
      answers: answer.answers,
    );
  }
}

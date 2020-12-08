import 'package:HealthSup/features/decision_tree/data/models/possible_answer_model.dart';
import 'package:HealthSup/features/decision_tree/data/models/question_type_model.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/question.dart';
import 'package:flutter/foundation.dart';

class QuestionModel extends Question {
  QuestionModel({
    @required int id,
    @required int code,
    @required String title,
    @required QuestionTypeModel questionType,
    @required List<PossibleAnswerModel> possibleAnswers,
  }) : super(
          id: id,
          code: code,
          title: title,
          questionType: questionType,
          possibleAnswers: possibleAnswers,
        );

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return QuestionModel(
      id: json['id'],
      code: json["code"],
      title: json['title'],
      questionType: QuestionTypeModel.fromJson(json["questionType"]),
      possibleAnswers:
          PossibleAnswerModel.listFromJson(json['possibleAnswers']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['id'] = id;
    if (code != null) json['code'] = code;
    if (title != null) json['title'] = title;
    if (questionType != null) json['questionType'] = questionType;
    if (possibleAnswers != null)
      json['possibleAnswers'] = PossibleAnswerModel.listToJson(possibleAnswers);

    return json;
  }

  factory QuestionModel.fromEntity(Question question) {
    if (question == null) return null;

    return QuestionModel(
      id: question.id,
      code: question.code,
      questionType: question.questionType,
      title: question.title,
      possibleAnswers: question.possibleAnswers,
    );
  }
}

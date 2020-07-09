import 'package:cardiompp/features/decision_tree/data/models/possible_answer_model.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/question.dart';
import 'package:flutter/foundation.dart';

class QuestionModel extends Question {
  QuestionModel({
    @required int questionCode,
    @required String title,
    @required List<PossibleAnswerModel> possibleAnswers,
    @required int questionTypeCode,
  }) : super(
            questionCode: questionCode,
            title: title,
            possibleAnswers: possibleAnswers,
            questionTypeCode: questionTypeCode);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return QuestionModel(
      questionCode: json['QuestionCode'],
      title: json['Title'],
      possibleAnswers: PossibleAnswerModel.listFromJson(json['PossibleAnswers']),
      questionTypeCode: json['QuestionTypeCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (questionCode != null) json['QuestionCode'] = questionCode;
    if (title != null) json['Title'] = title;
    if (possibleAnswers != null)
      json['PossibleAnswers'] = PossibleAnswerModel.listToJson(possibleAnswers);
    if (questionTypeCode != null) json['QuestionTypeCode'] = questionTypeCode;

    return json;
  }
}

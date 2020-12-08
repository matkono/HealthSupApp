import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:flutter/foundation.dart';

class PossibleAnswerModel extends PossibleAnswer {
  PossibleAnswerModel({
    @required int id,
    @required int code,
    @required String title,
    @required int possibleAnswerGroup,
  }) : super(
          id: id,
          code: code,
          title: title,
          possibleAnswerGroupId: possibleAnswerGroup,
        );

  factory PossibleAnswerModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return PossibleAnswerModel(
      id: json['id'],
      code: json['code'],
      title: json["title"],
      possibleAnswerGroup: json['possibleAnswerGroup']['id'],
    );
  }

  static List<dynamic> listToJson(List<PossibleAnswerModel> list) {
    if (list == null) return null;

    List<dynamic> json = [];

    for (PossibleAnswerModel i in list) {
      json.add(i.id);
    }

    return json;
  }

  static List<PossibleAnswerModel> listFromJson(List<dynamic> json) {
    if (json == null) return null;

    List<PossibleAnswerModel> list = [];

    for (dynamic i in json) {
      list.add(PossibleAnswerModel.fromJson(i));
    }

    return list;
  }

  factory PossibleAnswerModel.fromEntity(PossibleAnswer possibleAnswer) {
    if (possibleAnswer == null) return null;

    return PossibleAnswerModel(
      id: possibleAnswer.id,
      code: possibleAnswer.code,
      title: possibleAnswer.title,
      possibleAnswerGroup: possibleAnswer.possibleAnswerGroupId,
    );
  }
}

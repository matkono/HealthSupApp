import 'package:HealthSup/features/decision_tree/data/models/possible_answer_group_model.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer_group.dart';
import 'package:flutter/foundation.dart';

class PossibleAnswerModel extends PossibleAnswer {
  PossibleAnswerModel({
    @required int id,
    @required int code,
    @required String title,
    @required PossibleAnswerGroup possibleAnswerGroup,
  }) : super(
          id: id,
          code: code,
          title: title,
          possibleAnswerGroup: possibleAnswerGroup,
        );

  factory PossibleAnswerModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return PossibleAnswerModel(
      id: json['id'],
      code: json['code'],
      title: json["title"],
      possibleAnswerGroup:
          PossibleAnswerGroupModel.fromJson(json["possibleAnswerGroup"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['Id'] = id;

    return json;
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
      list.add(PossibleAnswerModel.fromJson(i));
    }

    return list;
  }
}

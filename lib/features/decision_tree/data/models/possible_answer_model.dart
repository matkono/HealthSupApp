import 'package:cardiompp/features/decision_tree/domain/entities/possible_Answer.dart';
import 'package:flutter/foundation.dart';

class PossibleAnswerModel extends PossibleAnswer {
  PossibleAnswerModel({
    @required int id,
    @required String value,
  }) : super(id: id, value: value);

  factory PossibleAnswerModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return PossibleAnswerModel(
      id: json['Id'],
      value: json['Value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['Id'] = id;
    if (value != null) json['Value'] = value;

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

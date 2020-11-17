import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer_group.dart';
import 'package:flutter/foundation.dart';

class PossibleAnswerGroupModel extends PossibleAnswerGroup {
  PossibleAnswerGroupModel({
    @required int id,
  }) : super(
          id: id,
        );

  factory PossibleAnswerGroupModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return PossibleAnswerGroupModel(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['id'] = id;

    return json;
  }
}

import 'package:healthsup/features/decision_tree/domain/entities/question_type.dart';
import 'package:flutter/foundation.dart';

class QuestionTypeModel extends QuestionType {
  QuestionTypeModel({
    @required int id,
    @required int code,
  }) : super(
          id: id,
          code: code,
        );

  factory QuestionTypeModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;

    return QuestionTypeModel(
      id: json['id'],
      code: json['code'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['id'] = id;
    if (code != null) json['code'] = code;

    return json;
  }
}

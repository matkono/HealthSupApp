import 'package:healthsup/features/decision_tree/domain/entities/decision.dart';
import 'package:flutter/foundation.dart';

class DecisionModel extends Decision {
  DecisionModel({
    @required int id,
    @required int code,
    @required String title,
    @required bool isFinal,
  }) : super(id: id, code: code, title: title, isFinal: isFinal);

  factory DecisionModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DecisionModel(
      id: json['id'],
      code: json['code'],
      title: json['title'],
      isFinal: json['isFinal'],
    );
  }
}

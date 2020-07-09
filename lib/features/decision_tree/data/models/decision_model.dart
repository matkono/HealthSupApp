import 'package:cardiompp/features/decision_tree/domain/entities/decision.dart';
import 'package:flutter/foundation.dart';

class DecisionModel extends Decision {
  DecisionModel({
    @required String title,
    @required bool isFinal,
  }) : super(title: title, isFinal: isFinal);

  factory DecisionModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DecisionModel(
      title: json['Title'],
      isFinal: json['IsFinal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'IsFinal': isFinal,
    };
  }
}
import 'package:HealthSup/features/decision_tree/domain/entities/decision_tree.dart';
import 'package:flutter/foundation.dart';

class DecisionTreeModel extends DecisionTree {
  DecisionTreeModel({
    @required int id,
  }) : super(
          id: id,
        );

  factory DecisionTreeModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;

    return DecisionTreeModel(
      id: json['id'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['id'] = id;

    return json;
  }
}

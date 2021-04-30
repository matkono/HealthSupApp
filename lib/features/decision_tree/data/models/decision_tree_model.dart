import 'package:healthsup/features/decision_tree/domain/entities/decision_tree.dart';
import 'package:flutter/foundation.dart';
import 'package:healthsup/features/disease/data/models/disease_model.dart';
import 'package:healthsup/features/disease/domain/entities/diseases.dart';

class DecisionTreeModel extends DecisionTree {
  DecisionTreeModel({
    @required int id,
    @required Diseases diseases,
  }) : super(
          id: id,
          diseases: diseases,
        );

  factory DecisionTreeModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;

    return DecisionTreeModel(
      id: json['id'],
      diseases: DiseasesModel.fromJson(json['disease']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['id'] = id;
    if (diseases != null) json['disease'] = diseases;

    return json;
  }
}

import 'package:HealthSup/features/decision_tree/data/models/question_model.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:flutter/foundation.dart';

class NodeModel extends Node {
  final QuestionModel questionModel;

  NodeModel({
    @required this.questionModel,
  }) : super(question: questionModel);

  factory NodeModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;

    return NodeModel(
      questionModel: QuestionModel.fromJson(json['data']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (questionModel != null) json['data'] = questionModel.toJson();

    return json;
  }
}

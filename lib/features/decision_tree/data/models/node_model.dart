import 'package:cardiompp/features/decision_tree/data/models/decision_model.dart';
import 'package:cardiompp/features/decision_tree/data/models/question_model.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/node.dart';
import 'package:flutter/foundation.dart';

class NodeModel extends Node {
  final QuestionModel questionModel;
  final DecisionModel decisionModel;

  NodeModel({
    @required int nodeTypeCode,
    @required this.questionModel,
    @required this.decisionModel,
  }) : super(
            nodeTypeCode: nodeTypeCode,
            question: questionModel,
            decision: decisionModel);

  factory NodeModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;

    return NodeModel(
      nodeTypeCode: json['NodeTypeCode'],
      questionModel: QuestionModel.fromJson(json['Question']),
      decisionModel: DecisionModel.fromJson(json['Decision']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (nodeTypeCode != null) json['NodeTypeCode'] = nodeTypeCode;
    if (questionModel != null) json['Question'] = questionModel.toJson();
    if (decisionModel != null) json['Decision'] = decisionModel.toJson();

    return json;
  }
}

import 'package:HealthSup/features/decision_tree/data/models/possible_answer_model.dart';
import 'package:HealthSup/features/decision_tree/data/models/question_type_model.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:flutter/foundation.dart';

import 'decision_tree_model.dart';
import 'node_type_model.dart';

class NodeModel extends Node {
  NodeModel({
    @required int questionId,
    @required int code,
    @required String title,
    @required QuestionTypeModel questionType,
    @required List<PossibleAnswerModel> possibleAnswers,
    @required int id,
    @required bool isInitial,
    @required NodeTypeModel nodeType,
    @required DecisionTreeModel decisionTree,
  }) : super(
          questionId: questionId,
          code: code,
          title: title,
          questionType: questionType,
          possibleAnswers: possibleAnswers,
          id: id,
          isInitial: isInitial,
          nodeType: nodeType,
          decisionTree: decisionTree,
        );

  factory NodeModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return NodeModel(
      questionId: json['questionId'],
      code: json["code"],
      title: json['title'],
      questionType: QuestionTypeModel.fromJson(json["questionType"]),
      possibleAnswers:
          PossibleAnswerModel.listFromJson(json['possibleAnswers']),
      id: json["id"],
      isInitial: json["isInitial"],
      nodeType: NodeTypeModel.fromJson(json["nodeType"]),
      decisionTree: DecisionTreeModel.fromJson(json["decisionTree"]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (questionId != null) json['questionId'] = questionId;
    if (code != null) json['code'] = code;
    if (title != null) json['title'] = title;
    if (questionType != null) json['questionType'] = questionType;
    if (possibleAnswers != null)
      json['possibleAnswers'] = PossibleAnswerModel.listToJson(possibleAnswers);
    if (id != null) json['id'] = id;
    if (isInitial != null) json['isInitial'] = isInitial;
    if (nodeType != null) json['nodeType'] = json['nodeType'];

    return json;
  }
}

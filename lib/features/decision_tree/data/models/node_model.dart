import 'package:healthsup/features/decision_tree/data/models/action_model.dart';
import 'package:healthsup/features/decision_tree/data/models/decision_model.dart';
import 'package:healthsup/features/decision_tree/data/models/question_model.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:flutter/foundation.dart';
import 'node_type_model.dart';

class NodeModel extends Node {
  NodeModel({
    @required QuestionModel questionModel,
    @required DecisionModel decisionModel,
    @required ActionModel actionModel,
    @required int id,
    @required bool isInitial,
    @required NodeTypeModel nodeTypeModel,
    @required int idAppointment,
  }) : super(
          question: questionModel,
          decision: decisionModel,
          action: actionModel,
          id: id,
          isInitial: isInitial,
          nodeType: nodeTypeModel,
          idAppointment: idAppointment,
        );

  factory NodeModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return NodeModel(
        questionModel: QuestionModel.fromJson(json['question']),
        decisionModel: DecisionModel.fromJson(json['decision']),
        actionModel: ActionModel.fromJson(json['action']),
        id: json["id"],
        isInitial: json["isInitial"],
        nodeTypeModel: NodeTypeModel.fromJson(json['nodeType']),
        idAppointment: json["idAppointment"]);
  }
}

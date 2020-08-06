import 'dart:convert';
import 'package:HealthSup/core/error/exception.dart';
import 'package:HealthSup/features/decision_tree/data/models/answer_model.dart';
import 'package:HealthSup/features/decision_tree/data/models/node_model.dart';
import 'package:flutter/services.dart';

abstract class RemoteDataSource {
  Future<NodeModel> getFirstNodeMedicalAppointment();
  Future<NodeModel> setAnswer(AnswerModel answer);
  Future<NodeModel> getLastQuestion(int idQuestion);
}

class RemoteDataSourceImpl extends RemoteDataSource {

  @override
  Future<NodeModel> getFirstNodeMedicalAppointment() async {

    try {
    String body = await rootBundle.loadString('assets/contract_question.json');
    Map jsonNodeResponse = json.decode(body);
    
    return NodeModel.fromJson(jsonNodeResponse);

    } catch(e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<NodeModel> setAnswer(AnswerModel answer) async {

    try {
    String body = await rootBundle.loadString('assets/contract_decision.json');
    Map jsonDecisionResponse = json.decode(body);

    return NodeModel.fromJson(jsonDecisionResponse);

    } catch(e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<NodeModel> getLastQuestion(int idQuestion) async {
    try {
    String body = await rootBundle.loadString('assets/contract_question.json');
    Map jsonNodeResponse = json.decode(body);

    return NodeModel.fromJson(jsonNodeResponse);

    } catch(e) {
      print(e);
      throw ServerException();
    }
  }
}

import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/contract_answer.dart';
import 'package:flutter/foundation.dart';

class ContractAnswerModel extends ContractAnswer {
  ContractAnswerModel({
    @required int questionCode,
    @required Answer answer,
  }) : super(questionCode: questionCode, answer: answer);

  factory ContractAnswerModel.fromJson(Map<String, dynamic> json) {
    return ContractAnswerModel(
      questionCode: json['QuestionCode'],
      answer: json['Answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'QuestionCode': questionCode,
      'Answer': answer,
    };
  }
}
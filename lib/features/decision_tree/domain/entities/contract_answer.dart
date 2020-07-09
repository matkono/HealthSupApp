import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ContractAnswer extends Equatable {
  
  final int questionCode;
  final Answer answer;

  ContractAnswer({
    @required this.questionCode,
    @required this.answer,
  });
  
  @override
  List<Object> get props => [questionCode, answer];
}
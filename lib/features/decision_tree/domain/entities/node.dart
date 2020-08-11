import 'package:HealthSup/features/decision_tree/domain/entities/decision.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/question.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Node extends Equatable {
  final int nodeTypeCode;
  final Question question;
  final Decision decision;

  Node({
    @required this.nodeTypeCode,
    @required this.question,
    @required this.decision,
  });

  @override
  List<Object> get props => [nodeTypeCode, question, decision];
}
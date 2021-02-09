import 'package:healthsup/features/decision_tree/domain/entities/action.dart';
import 'package:healthsup/features/decision_tree/domain/entities/decision.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node_type.dart';
import 'package:healthsup/features/decision_tree/domain/entities/question.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Node extends Equatable {
  final Question question;
  final Decision decision;
  final Action action;
  final int id;
  final bool isInitial;
  final NodeType nodeType;

  Node({
    @required this.question,
    @required this.decision,
    @required this.action,
    @required this.id,
    @required this.isInitial,
    @required this.nodeType,
  });

  @override
  List<Object> get props => [
        question,
        id,
        isInitial,
        nodeType,
      ];
}

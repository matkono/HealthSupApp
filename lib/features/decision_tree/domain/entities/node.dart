import 'package:HealthSup/features/decision_tree/domain/entities/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Node extends Equatable {
  final Data question;

  Node({
    @required this.question,
  });

  @override
  List<Object> get props => [question];
}

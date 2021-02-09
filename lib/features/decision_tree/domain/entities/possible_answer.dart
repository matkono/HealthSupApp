import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PossibleAnswer extends Equatable {
  final int id;
  final int code;
  final String title;
  final int possibleAnswerGroupId;

  PossibleAnswer({
    @required this.id,
    @required this.code,
    @required this.title,
    @required this.possibleAnswerGroupId,
  });

  @override
  List<Object> get props => [id, code, title, possibleAnswerGroupId];
}

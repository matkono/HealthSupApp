import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PossibleAnswerGroup extends Equatable {
  final int id;

  PossibleAnswerGroup({
    @required this.id,
    });

  @override
  List<Object> get props => [id];
}
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PossibleAnswer extends Equatable {
  final int id;
  final String value;

  PossibleAnswer({
    @required this.id,
    @required this.value,
  });

  @override
  List<Object> get props => [id, value];
}
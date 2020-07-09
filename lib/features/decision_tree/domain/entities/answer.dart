import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Answer extends Equatable {
  // final String value;
  // final int code;
  final List<Map<String, int>> answers;

  Answer({
    // @required this.value,
    // @required this.code,
    @required this.answers,
  });

  @override
  List<Object> get props => [answers];
}
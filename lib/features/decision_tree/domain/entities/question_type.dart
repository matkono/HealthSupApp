import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class QuestionType extends Equatable {
  final int id;
  final int code;


  QuestionType({
    @required this.id,
    @required this.code,
    });

  @override
  List<Object> get props => [id, code];
}
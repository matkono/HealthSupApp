import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Action extends Equatable {

  final int id;
  final int code;
  final String title;

  Action({
    @required this.id,
    @required this.code,
    @required this.title,
  });

  @override
  List<Object> get props => [id, code, title];
}
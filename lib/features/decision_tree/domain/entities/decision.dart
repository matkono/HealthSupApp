import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Decision extends Equatable {
  final int id;
  final int code;
  final String title;
  final bool isFinal;

  Decision({
    @required this.id,
    @required this.code,
    @required this.title,
    @required this.isFinal,
  });

  @override
  List<Object> get props => [id, code, title, isFinal];
}

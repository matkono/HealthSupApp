import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Decision extends Equatable {

  final String title;
  final bool isFinal;

  Decision({
    @required this.title,
    @required this.isFinal,
  });

  @override
  List<Object> get props => [title, isFinal];
}
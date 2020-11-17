import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NodeType extends Equatable {
  final int id;
  final int code;

  NodeType({
    @required this.id,
    @required this.code,
  });

  @override
  List<Object> get props => [id, code];
}

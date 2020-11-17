import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DecisionTree extends Equatable {

  final int id;

  DecisionTree({
    @required this.id,
  });

  @override
  List<Object> get props => [id];

}
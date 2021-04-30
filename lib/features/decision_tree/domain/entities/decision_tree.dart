import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/disease/domain/entities/diseases.dart';

class DecisionTree extends Equatable {
  final int id;
  final Diseases diseases;

  DecisionTree({
    @required this.id,
    @required this.diseases,
  });

  @override
  List<Object> get props => [id, diseases];
}

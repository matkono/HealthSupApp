import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChoosedDisease extends Equatable {
  final int patientId;
  final int diseaseId;

  ChoosedDisease({
    @required this.patientId,
    @required this.diseaseId,
  });

  @override
  List<Object> get props => [patientId, diseaseId];
}

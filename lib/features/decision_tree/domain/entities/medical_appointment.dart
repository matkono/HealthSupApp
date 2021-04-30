import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/decision_tree/domain/entities/decision_tree.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/domain/entities/status_medical_appointment.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';

class MedicalAppointment extends Equatable {
  final int id;
  final bool isDiagnostic;
  final Patient patient;
  final DecisionTree decisionTree;
  final Node currentNode;
  final StatusMedicalAppointment status;

  MedicalAppointment({
    @required this.id,
    @required this.isDiagnostic,
    @required this.patient,
    @required this.decisionTree,
    @required this.currentNode,
    @required this.status,
  });

  @override
  List<Object> get props => [
        id,
        isDiagnostic,
        patient,
        decisionTree,
        currentNode,
        status,
      ];
}

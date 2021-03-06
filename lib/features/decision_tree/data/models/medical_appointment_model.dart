import 'package:flutter/material.dart';
import 'package:healthsup/features/decision_tree/data/models/decision_tree_model.dart';
import 'package:healthsup/features/decision_tree/data/models/node_model.dart';
import 'package:healthsup/features/decision_tree/data/models/status_medical_appointment_model.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/decision_tree/domain/entities/decision_tree.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/domain/entities/status_medical_appointment.dart';
import 'package:healthsup/features/patient/data/models/patient_model.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';

class MedicalAppointmentModel extends MedicalAppointment {
  MedicalAppointmentModel({
    @required int id,
    @required bool isDiagnostic,
    @required Patient patient,
    @required DecisionTree decisionTree,
    @required Node currentNode,
    @required StatusMedicalAppointment statusMedicalAppointment,
  }) : super(
          id: id,
          isDiagnostic: isDiagnostic,
          patient: patient,
          decisionTree: decisionTree,
          currentNode: currentNode,
          statusMedicalAppointment: statusMedicalAppointment,
        );

  factory MedicalAppointmentModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;

    return MedicalAppointmentModel(
      id: json['id'],
      isDiagnostic: json['isDiagnostic'],
      patient: PatientModel.fromJson(json['patient']),
      decisionTree: DecisionTreeModel.fromJson(json['decisionTree']),
      currentNode: NodeModel.fromJson(json['currentNode']),
      statusMedicalAppointment:
          StatusMedicalAppointmentModel.fromJson(json['status']),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:healthsup/features/decision_tree/domain/entities/status_medical_appointment.dart';

class StatusMedicalAppointmentModel extends StatusMedicalAppointment {
  StatusMedicalAppointmentModel({
    @required int id,
    @required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory StatusMedicalAppointmentModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return StatusMedicalAppointmentModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

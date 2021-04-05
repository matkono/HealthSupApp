import 'package:flutter/material.dart';
import 'package:healthsup/features/decision_tree/data/models/medical_appointment_model.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment_list.dart';

class MedicalAppointmentListModel extends MedicalAppointmentList {
  MedicalAppointmentListModel({
    @required List<MedicalAppointment> medicalAppointmentList,
    @required int pageNumber,
    @required int pageSize,
    @required int totalRows,
  }) : super(
          medicalAppointment: medicalAppointmentList,
          pageNumber: pageNumber,
          pageSize: pageSize,
          totalRows: totalRows,
        );

  factory MedicalAppointmentListModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return null;

    return MedicalAppointmentListModel(
      medicalAppointmentList:
          MedicalAppointmentModel.listFromJson(json['medicalAppointments']),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalRows: json['totalRows'],
    );
  }

  static List<MedicalAppointmentListModel> listFromJson(List<dynamic> json) {
    if (json == null) return null;

    List<MedicalAppointmentListModel> list = [];

    for (dynamic i in json) {
      list.add(MedicalAppointmentListModel.fromJson(i));
    }

    return list;
  }
}

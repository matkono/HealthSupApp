import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';

class MedicalAppointmentList extends Equatable {
  final List<MedicalAppointment> medicalAppointment;
  final int pageNumber;
  final int pageSize;
  final int totalRows;

  MedicalAppointmentList({
    @required this.medicalAppointment,
    @required this.pageNumber,
    @required this.pageSize,
    @required this.totalRows,
  });

  @override
  List<Object> get props => [
        medicalAppointment,
        pageNumber,
        pageSize,
        totalRows,
      ];
}

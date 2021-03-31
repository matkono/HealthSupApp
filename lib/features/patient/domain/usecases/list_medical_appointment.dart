import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment_list.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';
import 'package:healthsup/features/patient/domain/repositories/patient_repository.dart';

class ListMedicalAppointment
    extends UseCase<MedicalAppointmentList, MedicalAppointmentParams> {
  final PatientRepository patientRepository;

  ListMedicalAppointment(
    this.patientRepository,
  );

  @override
  Future<Either<Failure, MedicalAppointmentList>> call(
      MedicalAppointmentParams params) async {
    return await patientRepository.searchMedicalAppointment(
        params.patientID, params.pagination);
  }
}

class MedicalAppointmentParams extends Equatable {
  final int patientID;
  final Pagination pagination;

  MedicalAppointmentParams({
    @required this.patientID,
    @required this.pagination,
  });

  @override
  List<Object> get props => [patientID, pagination];
}

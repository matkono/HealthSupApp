import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/patient/domain/usecases/list_medical_appointment.dart';
import 'package:healthsup/features/patient/domain/usecases/list_patient.dart';
import 'package:healthsup/features/patient/domain/usecases/search_patient.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  List<MedicalAppointment> medicalAppointmentList = [];
  final ListPatient listPatient;
  final SearchPatient searchPatient;
  final ListMedicalAppointment listMedicalAppointment;
  Pagination _currentPagination;
  Patient _patient;

  PatientBloc({
    @required this.listPatient,
    @required this.searchPatient,
    @required this.listMedicalAppointment,
  }) : super(PatientInitial());

  @override
  Stream<PatientState> mapEventToState(
    PatientEvent event,
  ) async* {
    if (event is SearchPatientEvent) {
      yield LoadingPatientState(patient: _patient);

      _currentPagination = new Pagination(pageNumber: 1, pageSize: 10);

      var failureOrNode = await searchPatient(ParamsSearchPatient(
        registration: event.registration,
      ));

      var patientInfo = failureOrNode.fold(
        (failure) => null,
        (patient) => patient,
      );

      _patient = patientInfo;

      var failureOrList = await listMedicalAppointment(MedicalAppointmentParams(
        patientID: patientInfo.id,
        pagination: _currentPagination,
      ));
      yield failureOrList.fold(
        (failure) {
          if (failure is ServerFailure)
            return ErrorSearchedPatientState(message: failure.failureMessage);
          else if (failure is NoInternetConnectionFailure)
            return ErrorSearchedPatientState(message: failure.failureMessage);
          else
            return ErrorSearchedPatientState(message: 'Erro desconhecido');
        },
        (patient) {
          if (patient != null) {
            medicalAppointmentList = patient.medicalAppointment;
            return SearchedPatientState(
              patient: patientInfo,
              medicalAppointmentList: patient.medicalAppointment,
              totalRows: patient.totalRows,
            );
          } else
            return ErrorSearchedPatientState(message: 'Código inválido');
        },
      );
    } else if (event is GetNextAppointmentListEvent) {
      yield LoadingPatientState(patient: _patient);

      _currentPagination = new Pagination(
          pageNumber: _currentPagination.pageNumber + 1,
          pageSize: _currentPagination.pageSize);

      var failureOrList = await listMedicalAppointment(MedicalAppointmentParams(
        patientID: _patient.id,
        pagination: _currentPagination,
      ));
      yield failureOrList.fold(
        (failure) {
          if (failure is ServerFailure)
            return ErrorSearchedPatientState(message: failure.failureMessage);
          else if (failure is NoInternetConnectionFailure)
            return ErrorSearchedPatientState(message: failure.failureMessage);
          else
            return ErrorSearchedPatientState(message: 'Erro desconhecido');
        },
        (patient) {
          if (patient == null) {
            return ErrorSearchMedicalAppointmentState(
                message: 'Doenças não encontradas!');
          } else {
            if (patient.pageNumber == 0) {
              medicalAppointmentList.clear();
            }
            medicalAppointmentList.addAll(patient.medicalAppointment);
            return ListedAppointmentState(
              patient: _patient,
              medicalAppointment: medicalAppointmentList,
              totalRows: patient.totalRows,
            );
          }
        },
      );
    }
  }
}

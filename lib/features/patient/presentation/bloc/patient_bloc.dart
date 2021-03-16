import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/patient/domain/usecases/list_patient.dart';
import 'package:healthsup/features/patient/domain/usecases/search_patient.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final ListPatient listPatient;
  final SearchPatient searchPatient;

  PatientBloc({
    @required this.listPatient,
    @required this.searchPatient,
  }) : super(PatientInitial());

  @override
  Stream<PatientState> mapEventToState(
    PatientEvent event,
  ) async* {
    if (event is SearchPatientEvent) {
      yield LoadingPatientState();

      var failureOrNode = await searchPatient(ParamsSearchPatient(
        registration: event.registration,
      ));
      yield failureOrNode.fold(
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
            return SearchedPatientState(
              patient: patient,
            );
          } else
            return ErrorSearchedPatientState(message: 'Código inválido');
        },
      );
    }
  }
}

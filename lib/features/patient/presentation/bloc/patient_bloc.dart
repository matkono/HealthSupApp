import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/patient/domain/entities/cep_info.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/patient/domain/usecases/list_patient.dart';
import 'package:healthsup/features/patient/domain/usecases/register_patient.dart';
import 'package:healthsup/features/patient/domain/usecases/search_patient.dart';
import 'package:healthsup/features/patient/domain/usecases/via_cep.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final ListPatient listPatient;
  final RegisterPatient registerPatient;
  final SearchPatient searchPatient;
  final ViaCep viaCep;

  PatientBloc({
    @required this.listPatient,
    @required this.registerPatient,
    @required this.searchPatient,
    @required this.viaCep,
    initialState,
  }) : super(initialState);

  @override
  Stream<PatientState> mapEventToState(
    PatientEvent event,
  ) async* {
    if (event is GetCepInfoEvent) {
      yield LoadingPatientState();

      var failureOrCep = await viaCep(CepParams(patient: event.patient));
      yield failureOrCep.fold(
        (failure) {
          if (failure is ServerFailure) {
            return ErrorPatientState(message: failure.failureMessage);
          } else if (failure is NoInternetConnectionFailure) {
            return ErrorPatientState(message: failure.failureMessage);
          } else {
            return ErrorPatientState(message: 'Erro desconhecido');
          }
        },
        (patientResult) {
          return LoadedPatientState(patient: patientResult);
        },
      );
    }
  }
}

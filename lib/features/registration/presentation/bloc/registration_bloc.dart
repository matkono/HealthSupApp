import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/domain/usecases/register_patient.dart';
import 'package:healthsup/features/registration/domain/usecases/via_cep.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final ViaCep viaCep;
  final RegisterPatient registerPatient;

  RegistrationBloc({
    @required this.viaCep,
    @required this.registerPatient,
  }) : super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is GetCepInfoEvent) {
      yield LoadingRegistrationState();

      var failureOrCep =
          await viaCep(CepParams(registerPatient: event.registerPatient));
      yield failureOrCep.fold(
        (failure) {
          if (failure is ServerFailure) {
            return ErrorRegistrationState(
                message: failure.failureMessage,
                registerPatient: event.registerPatient);
          } else if (failure is NoInternetConnectionFailure) {
            return ErrorRegistrationState(
                message: failure.failureMessage,
                registerPatient: event.registerPatient);
          } else {
            return ErrorRegistrationState(
                message: 'Erro desconhecido',
                registerPatient: event.registerPatient);
          }
        },
        (patientResult) {
          if (patientResult.cepInfo.cep == null) {
            return ErrorRegistrationState(
                message: 'CEP inválido!',
                registerPatient: event.registerPatient);
          } else {
            return LoadedRegistrationState(registerPatient: patientResult);
          }
        },
      );
    } else if (event is RegisterPatientEvent) {
      yield LoadingRegistrationState();

      var failureOrNode = await registerPatient(ParamsRegistrationPatient(
        registerPatient: event.registerPatient,
      ));
      yield failureOrNode.fold(
        (failure) {
          if (failure is ServerFailure)
            return ErrorRegistrationState(message: failure.failureMessage);
          else if (failure is NoInternetConnectionFailure)
            return ErrorRegistrationState(message: failure.failureMessage);
          else
            return ErrorRegistrationState(message: 'Erro desconhecido');
        },
        (patient) {
          if (patient != null) {
            return LoadedRegistrationState(
              registerPatient: patient,
            );
          } else
            return ErrorRegistrationState(message: 'Código inválido');
        },
      );
    }
  }
}

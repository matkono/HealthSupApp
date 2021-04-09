import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/domain/usecases/register_patient.dart';
import 'package:healthsup/features/registration/domain/usecases/update_patient.dart';
import 'package:healthsup/features/registration/domain/usecases/via_cep.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegisterPatientEntity registerPatientEntity;
  final ViaCep viaCep;
  final RegisterPatient registerPatient;
  final UpdatePatient updatePatient;

  RegistrationBloc({
    @required this.viaCep,
    @required this.registerPatient,
    @required this.updatePatient,
  }) : super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is GetCepRegistryEvent) {
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
          if (patientResult.address.cep == null) {
            return ErrorRegistrationState(
                message: 'CEP inválido!',
                registerPatient: event.registerPatient);
          } else {
            return LoadedCepRegistryState(registerPatient: patientResult);
          }
        },
      );
    } else if (event is RegisterPatientEvent) {
      yield LoadingRegistrationState();

      var failureOrNode = await registerPatient(ParamsRegistrationPatient(
        name: event.name,
        registration: event.registration,
        neighborhood: event.neighborhood,
        cep: event.cep,
        city: event.city,
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
            return LoadedRegistryState(
              registerPatientEntity: patient,
            );
          } else
            return ErrorRegistrationState(message: 'Código inválido');
        },
      );
    } else if (event is ClearEvent) {
      yield LoadingRegistrationState();
      registerPatientEntity = null;

      yield LoadedCepRegistryState(registerPatient: registerPatientEntity);
    } else if (event is GetCepUpdateEvent) {
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
          if (patientResult.address.cep == null) {
            return ErrorRegistrationState(
                message: 'CEP inválido!',
                registerPatient: event.registerPatient);
          } else {
            registerPatientEntity = new RegisterPatientEntity(
              id: registerPatientEntity.id,
              name: registerPatientEntity.name,
              registration: registerPatientEntity.registration,
              address: patientResult.address,
            );
            return LoadedCepUpdateState(registerPatient: registerPatientEntity);
          }
        },
      );
    } else if (event is UpdatePatientEvent) {
      yield LoadingRegistrationState();

      var failureOrNode = await updatePatient(ParamsUpdatePatient(
        address: event.address,
        patientID: event.patientID,
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
            return LoadedUpdateState(
              registerPatientEntity: patient,
            );
          } else
            return ErrorRegistrationState(message: 'Código inválido');
        },
      );
    } else if (event is EditPatientEvent) {
      yield LoadingRegistrationState();

      registerPatientEntity = event.patientEntity;

      yield LoadedCepUpdateState(registerPatient: registerPatientEntity);
    } else if (event is AddPatientEvent) {
      yield LoadingRegistrationState();

      registerPatientEntity = null;

      yield LoadedCepRegistryState(registerPatient: registerPatientEntity);
    }
  }
}

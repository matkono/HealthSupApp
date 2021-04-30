part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class LoadedCepRegistryState extends RegistrationState {
  final RegisterPatientEntity registerPatient;

  LoadedCepRegistryState({
    @required this.registerPatient,
  });
  @override
  List<Object> get props => [registerPatient];
}

class LoadedCepUpdateState extends RegistrationState {
  final RegisterPatientEntity registerPatient;

  LoadedCepUpdateState({
    @required this.registerPatient,
  });
  @override
  List<Object> get props => [registerPatient];
}

class LoadedRegistryState extends RegistrationState {
  final RegisterPatientEntity registerPatientEntity;

  LoadedRegistryState({
    @required this.registerPatientEntity,
  });
  List<Object> get props => [registerPatientEntity];
}

class LoadedUpdateState extends RegistrationState {
  final RegisterPatientEntity registerPatientEntity;

  LoadedUpdateState({
    @required this.registerPatientEntity,
  });
  List<Object> get props => [registerPatientEntity];
}

class LoadingRegistrationState extends RegistrationState {
  @override
  List<Object> get props => [];
}

class ErrorRegistrationState extends RegistrationState {
  final String message;
  final RegisterPatientEntity registerPatient;

  ErrorRegistrationState({
    this.message,
    this.registerPatient,
  });
  @override
  List<Object> get props => [message, registerPatient];
}

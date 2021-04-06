part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class LoadedCepState extends RegistrationState {
  final RegisterPatientEntity registerPatient;

  LoadedCepState({
    @required this.registerPatient,
  });
  @override
  List<Object> get props => [registerPatient];
}

class LoadedRegistrationState extends RegistrationState {
  final RegisterPatientEntity registerPatientEntity;

  LoadedRegistrationState({
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

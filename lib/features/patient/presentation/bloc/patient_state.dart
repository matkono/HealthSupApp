part of 'patient_bloc.dart';

abstract class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object> get props => [];
}

class PatientInitial extends PatientState {
  @override
  List<Object> get props => [];
}

class LoadedPatientState extends PatientState {
  final Patient patient;

  LoadedPatientState({
    @required this.patient,
  });

  @override
  List<Object> get props => [patient];
}

class LoadingPatientState extends PatientState {
  @override
  List<Object> get props => [];
}

class ErrorPatientState extends PatientState {
  final String message;

  ErrorPatientState({
    @required this.message,
  });

  @override
  List<Object> get props => [];
}

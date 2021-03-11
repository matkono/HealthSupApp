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

class SearchedPatientState extends PatientState {
  final Patient patient;

  SearchedPatientState({
    @required this.patient,
  });
}

class LoadingPatientState extends PatientState {
  @override
  List<Object> get props => [];
}

class ErrorPatientState extends PatientState {
  final Patient patient;
  final String message;

  ErrorPatientState({
    this.patient,
    @required this.message,
  });

  @override
  List<Object> get props => [patient, message];
}

class PatientRegistrationFinished extends PatientState {
  @override
  List<Object> get props => [];
}

class ErrorSearchedPatientState extends PatientState {
  final String message;

  ErrorSearchedPatientState({
    @required this.message,
  });

  List<Object> get props => [message];
}

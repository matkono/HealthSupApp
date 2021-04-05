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

class SearchedPatientState extends PatientState {
  final Patient patient;
  final List<MedicalAppointment> medicalAppointmentList;
  final int totalRows;

  SearchedPatientState({
    @required this.patient,
    @required this.medicalAppointmentList,
    @required this.totalRows,
  });

  @override
  List<Object> get props => [patient, medicalAppointmentList, totalRows];
}

class ListedAppointmentState extends PatientState {
  final Patient patient;
  final List<MedicalAppointment> medicalAppointment;
  final int totalRows;

  ListedAppointmentState({
    @required this.patient,
    @required this.medicalAppointment,
    @required this.totalRows,
  });

  List<Object> get props => [patient, medicalAppointment, totalRows];
}

class LoadingPatientState extends PatientState {
  final Patient patient;

  LoadingPatientState({
    @required this.patient,
  });

  @override
  List<Object> get props => [patient];
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

class ErrorSearchMedicalAppointmentState extends PatientState {
  final String message;

  ErrorSearchMedicalAppointmentState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

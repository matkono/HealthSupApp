part of 'patient_bloc.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

class SearchPatientEvent extends PatientEvent {
  final String registration;

  SearchPatientEvent({
    @required this.registration,
  });
}

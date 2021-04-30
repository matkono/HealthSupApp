part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterPatientEvent extends RegistrationEvent {
  final String name;
  final String registration;
  final String neighborhood;
  final String cep;
  final String city;

  RegisterPatientEvent({
    @required this.name,
    @required this.registration,
    @required this.neighborhood,
    @required this.cep,
    @required this.city,
  });
  @override
  List<Object> get props => [name, registration, neighborhood, cep, city];
}

class UpdatePatientEvent extends RegistrationEvent {
  final int patientID;
  final CepInfo address;

  UpdatePatientEvent({
    @required this.patientID,
    @required this.address,
  });
  @override
  List<Object> get props => [patientID, address];
}

class GetCepRegistryEvent extends RegistrationEvent {
  final RegisterPatientEntity registerPatient;

  GetCepRegistryEvent({
    @required this.registerPatient,
  });
  @override
  List<Object> get props => [registerPatient];
}

class GetCepUpdateEvent extends RegistrationEvent {
  final RegisterPatientEntity registerPatient;

  GetCepUpdateEvent({
    @required this.registerPatient,
  });
  @override
  List<Object> get props => [registerPatient];
}

class ClearEvent extends RegistrationEvent {}

class EditPatientEvent extends RegistrationEvent {
  final RegisterPatientEntity patientEntity;

  EditPatientEvent({
    @required this.patientEntity,
  });
  @override
  List<Object> get props => [patientEntity];
}

class AddPatientEvent extends RegistrationEvent {}

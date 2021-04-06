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
  List<Object> get props => [name, registration, neighborhood, cep, city];
}

class GetCepInfoEvent extends RegistrationEvent {
  final RegisterPatientEntity registerPatient;

  GetCepInfoEvent({
    @required this.registerPatient,
  });
  List<Object> get props => [registerPatient];
}

class ClearEvent extends RegistrationEvent {}

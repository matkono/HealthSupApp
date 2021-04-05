part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterPatientEvent extends RegistrationEvent {
  final RegisterPatientEntity registerPatient;

  RegisterPatientEvent({
    @required this.registerPatient,
  });
}

class GetCepInfoEvent extends RegistrationEvent {
  final RegisterPatientEntity registerPatient;

  GetCepInfoEvent({
    @required this.registerPatient,
  });
}

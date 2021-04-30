import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/domain/repositories/registration_repository.dart';

class RegisterPatient
    extends UseCase<RegisterPatientEntity, ParamsRegistrationPatient> {
  final RegistrationRepository registrationRepository;

  RegisterPatient(
    this.registrationRepository,
  );

  @override
  Future<Either<Failure, RegisterPatientEntity>> call(
      ParamsRegistrationPatient params) async {
    return await registrationRepository.registerPatient(params.name,
        params.registration, params.neighborhood, params.cep, params.city);
  }
}

class ParamsRegistrationPatient extends Equatable {
  final String name;
  final String registration;
  final String neighborhood;
  final String cep;
  final String city;

  ParamsRegistrationPatient({
    @required this.name,
    @required this.registration,
    @required this.neighborhood,
    @required this.cep,
    @required this.city,
  });

  @override
  List<Object> get props => [name, registration, neighborhood, cep, city];
}

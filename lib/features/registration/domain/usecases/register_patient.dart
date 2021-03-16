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
    return await registrationRepository.registerPatient(params.registerPatient);
  }
}

class ParamsRegistrationPatient extends Equatable {
  final RegisterPatientEntity registerPatient;

  ParamsRegistrationPatient({
    @required this.registerPatient,
  });

  @override
  List<Object> get props => [registerPatient];
}

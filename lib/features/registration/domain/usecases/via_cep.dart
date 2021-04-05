import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/domain/repositories/registration_repository.dart';

class ViaCep extends UseCase<RegisterPatientEntity, CepParams> {
  final RegistrationRepository registrationRepository;

  ViaCep(
    this.registrationRepository,
  );

  @override
  Future<Either<Failure, RegisterPatientEntity>> call(CepParams params) async {
    return await registrationRepository.viaCep(params.registerPatient);
  }
}

class CepParams extends Equatable {
  final RegisterPatientEntity registerPatient;

  CepParams({
    @required this.registerPatient,
  });

  @override
  List<Object> get props => [registerPatient];
}

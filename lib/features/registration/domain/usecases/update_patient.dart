import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/domain/repositories/registration_repository.dart';

class UpdatePatient
    extends UseCase<RegisterPatientEntity, ParamsUpdatePatient> {
  final RegistrationRepository registrationRepository;

  UpdatePatient(
    this.registrationRepository,
  );

  @override
  Future<Either<Failure, RegisterPatientEntity>> call(
      ParamsUpdatePatient params) async {
    return await registrationRepository.updatePatient(
        params.patientID, params.address);
  }
}

class ParamsUpdatePatient extends Equatable {
  final int patientID;
  final CepInfo address;

  ParamsUpdatePatient({
    @required this.patientID,
    @required this.address,
  });

  @override
  List<Object> get props => [patientID, address];
}

import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/patient/domain/entities/cep_info.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthsup/features/patient/domain/repositories/patient_repository.dart';

class ViaCep extends UseCase<CepInfo, CepParams> {
  final PatientRepository patientRepository;

  ViaCep(
    this.patientRepository,
  );

  @override
  Future<Either<Failure, CepInfo>> call(CepParams params) async {
    return await patientRepository.viaCep(params.cep);
  }
}

class CepParams extends Equatable {
  final String cep;

  CepParams({
    @required this.cep,
  });

  @override
  List<Object> get props => [cep];
}

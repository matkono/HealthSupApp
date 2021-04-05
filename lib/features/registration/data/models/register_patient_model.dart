import 'package:flutter/material.dart';
import 'package:healthsup/features/registration/data/models/cep_info_model.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';

class RegisterPatientModel extends RegisterPatientEntity {
  RegisterPatientModel({
    @required String name,
    @required String registration,
    @required CepInfoModel cepInfo,
  }) : super(
          name: name,
          registration: registration,
          cepInfo: cepInfo,
        );

  @override
  List<Object> get props => [name, registration, cepInfo];
}

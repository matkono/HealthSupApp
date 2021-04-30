import 'package:flutter/material.dart';
import 'package:healthsup/features/registration/data/models/cep_info_model.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';

class RegisterPatientModel extends RegisterPatientEntity {
  RegisterPatientModel({
    int id,
    @required String name,
    @required String registration,
    @required CepInfoModel cepInfo,
  }) : super(
          id: id,
          name: name,
          registration: registration,
          address: cepInfo,
        );

  factory RegisterPatientModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return RegisterPatientModel(
      id: json['id'],
      name: json['name'],
      registration: json['registration'],
      cepInfo: CepInfoModel.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registration': registration,
      'address': address,
    };
  }
}

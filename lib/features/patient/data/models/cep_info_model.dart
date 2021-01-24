import 'package:flutter/material.dart';
import 'package:healthsup/features/patient/domain/entities/cep_info.dart';

class CepInfoModel extends CepInfo {
  CepInfoModel({
    @required String cep,
    @required String logradouro,
    @required String bairro,
    @required String localidade,
  }) : super(
          cep: cep,
          logradouro: logradouro,
          bairro: bairro,
          localidade: localidade,
        );

  factory CepInfoModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return CepInfoModel(
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      localidade: json['localidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'Neighborhood': bairro,
      'localidade': localidade,
    };
  }
}

import 'package:flutter/material.dart';
import 'package:healthsup/features/patient/domain/entities/cep_info.dart';

class CepInfoModel extends CepInfo {
  CepInfoModel({
    @required String cep,
    @required String logradouro,
    @required String complemento,
    @required String bairro,
    @required String localidade,
    @required String uf,
    @required String unidade,
    @required String ibge,
    @required String gia,
  }) : super(
          cep: cep,
          logradouro: logradouro,
          complemento: complemento,
          bairro: bairro,
          localidade: localidade,
          uf: uf,
          unidade: unidade,
          ibge: ibge,
          gia: gia,
        );

  factory CepInfoModel.fromJson(Map<String, dynamic> json) {
    return CepInfoModel(
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      unidade: json['unidade'],
      ibge: json['ibge'],
      gia: json['gia'],
    );
  }
}

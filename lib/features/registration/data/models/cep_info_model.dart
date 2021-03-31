import 'package:flutter/material.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';

class CepInfoModel extends CepInfo {
  CepInfoModel({
    @required String cep,
    @required String neighborhood,
    @required String city,
  }) : super(
          cep: cep,
          neighborhood: neighborhood,
          city: city,
        );

  factory CepInfoModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return CepInfoModel(
      cep: json['cep'],
      neighborhood: json['neighborhood'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'neighborhood': neighborhood,
      'city': city,
    };
  }
}

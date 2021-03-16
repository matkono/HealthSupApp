import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CepInfo extends Equatable {
  final String cep;
  // final String logradouro;
  final String neighborhood;
  final String city;

  CepInfo({
    @required this.cep,
    // @required this.logradouro,
    @required this.neighborhood,
    @required this.city,
  });

  @override
  List<Object> get props => [
        cep,
        // logradouro,
        neighborhood,
        city,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CepInfo extends Equatable {
  final String cep;
  final String logradouro;
  final String bairro;
  final String localidade;

  CepInfo({
    @required this.cep,
    @required this.logradouro,
    @required this.bairro,
    @required this.localidade,
  });

  @override
  List<Object> get props => [
        cep,
        logradouro,
        bairro,
        localidade,
      ];
}

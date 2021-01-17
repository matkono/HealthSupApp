import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CepInfo extends Equatable {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String unidade;
  final String ibge;
  final String gia;

  CepInfo({
    @required this.cep,
    @required this.logradouro,
    @required this.complemento,
    @required this.bairro,
    @required this.localidade,
    @required this.uf,
    @required this.unidade,
    @required this.ibge,
    @required this.gia,
  });

  @override
  List<Object> get props => [
        cep,
        logradouro,
        complemento,
        bairro,
        localidade,
        uf,
        unidade,
        ibge,
        gia,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';

class RegisterPatientEntity extends Equatable {
  final String name;
  final String registration;
  CepInfo cepInfo;

  RegisterPatientEntity({
    @required this.name,
    @required this.registration,
    @required this.cepInfo,
  });

  @override
  List<Object> get props => [name, registration, cepInfo];
}

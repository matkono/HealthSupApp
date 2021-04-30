import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';

class RegisterPatientEntity extends Equatable {
  final int id;
  final String name;
  final String registration;
  CepInfo address;

  RegisterPatientEntity({
    this.id,
    @required this.name,
    @required this.registration,
    @required this.address,
  });

  @override
  List<Object> get props => [id, name, registration, address];
}

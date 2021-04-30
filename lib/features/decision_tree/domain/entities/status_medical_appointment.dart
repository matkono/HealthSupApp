import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StatusMedicalAppointment extends Equatable {
  final int id;
  final String name;

  StatusMedicalAppointment({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [id, name];
}

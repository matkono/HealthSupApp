import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StatusMedicalAppointment extends Equatable {
  final int id;

  StatusMedicalAppointment({
    @required this.id,
  });

  @override
  List<Object> get props => [id];
}

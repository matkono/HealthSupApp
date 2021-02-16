import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Diseases extends Equatable {
  final int id;
  final String name;

  Diseases({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [id, name];
}

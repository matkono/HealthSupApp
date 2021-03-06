import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/disease/domain/entities/diseases.dart';

class DiseasesList extends Equatable {
  final List<Diseases> patients;
  final int pageNumber;
  final int pageSize;
  final int totalRows;

  DiseasesList({
    @required this.patients,
    @required this.pageNumber,
    @required this.pageSize,
    @required this.totalRows,
  });

  @override
  List<Object> get props => [patients, pageNumber, pageSize, totalRows];
}

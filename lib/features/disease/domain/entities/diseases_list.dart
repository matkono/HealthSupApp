import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/disease/domain/entities/diseases.dart';

class DiseasesList extends Equatable {
  final List<Diseases> disease;
  final int pageNumber;
  final int pageSize;
  final int totalRows;

  DiseasesList({
    @required this.disease,
    @required this.pageNumber,
    @required this.pageSize,
    @required this.totalRows,
  });

  @override
  List<Object> get props => [disease, pageNumber, pageSize, totalRows];
}

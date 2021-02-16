import 'package:flutter/material.dart';
import 'package:healthsup/features/disease/data/models/disease_model.dart';
import 'package:healthsup/features/disease/domain/entities/diseases.dart';
import 'package:healthsup/features/disease/domain/entities/diseases_list.dart';

class DiseaseListModel extends DiseasesList {
  DiseaseListModel({
    @required List<Diseases> disease,
    @required int pageNumber,
    @required int pageSize,
    @required int totalRows,
  }) : super(
          disease: disease,
          pageNumber: pageNumber,
          pageSize: pageSize,
          totalRows: totalRows,
        );

  factory DiseaseListModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DiseaseListModel(
      disease: DiseasesModel.listFromJson(json['diseases']),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalRows: json['totalRows'],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:healthsup/features/disease/domain/entities/choosed_disease.dart';

class ChoosedDiseaseModel extends ChoosedDisease {
  ChoosedDiseaseModel({
    @required int patientId,
    @required int diseaseId,
  }) : super(
          patientId: patientId,
          diseaseId: diseaseId,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (patientId != null) json['patientId'] = patientId;
    if (diseaseId != null) json['diseaseId'] = diseaseId;

    return json;
  }

  factory ChoosedDiseaseModel.fromEntity(ChoosedDisease choosedDisease) {
    if (choosedDisease == null) return null;

    return ChoosedDiseaseModel(
      patientId: choosedDisease.patientId,
      diseaseId: choosedDisease.diseaseId,
    );
  }

  static List<ChoosedDiseaseModel> listFromJson(List<dynamic> json) {
    if (json == null) return null;

    List<ChoosedDiseaseModel> list = [];

    for (dynamic i in json) {
      list.add(i);
    }

    return list;
  }
}

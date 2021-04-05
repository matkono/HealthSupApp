import 'package:flutter/material.dart';
import 'package:healthsup/features/disease/domain/entities/diseases.dart';

class DiseasesModel extends Diseases {
  DiseasesModel({
    @required id,
    @required name,
  }) : super(
          id: id,
          name: name,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (id != null) json['id'] = id;
    if (name != null) json['name'] = name;

    return json;
  }

  factory DiseasesModel.fromEntity(Diseases diseases) {
    if (diseases == null) return null;

    return DiseasesModel(
      id: diseases.id,
      name: diseases.name,
    );
  }

  factory DiseasesModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DiseasesModel(
      id: json['id'],
      name: json['name'],
    );
  }

  static List<dynamic> listToJson(List<DiseasesModel> list) {
    if (list == null) return null;

    List<dynamic> json = [];

    for (DiseasesModel i in list) {
      json.add(i.id);
      json.add(i.name);
    }

    return json;
  }

  static List<DiseasesModel> listFromJson(List<dynamic> json) {
    if (json == null) return null;

    List<DiseasesModel> list = [];

    for (dynamic i in json) {
      list.add(DiseasesModel.fromJson(i));
    }

    return list;
  }
}

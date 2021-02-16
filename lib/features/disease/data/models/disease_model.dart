import 'package:healthsup/features/disease/domain/entities/diseases.dart';

class DiseasesModel extends Diseases {
  DiseasesModel({
    final int id,
    final String name,
  }) : super(
          id: id,
          name: name,
        );

  factory DiseasesModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DiseasesModel(
      id: json['id'],
      name: json['name'],
    );
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

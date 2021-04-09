import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/registration/data/models/cep_info_model.dart';
import 'package:meta/meta.dart';

class PatientModel extends Patient {
  PatientModel({
    @required int id,
    @required String name,
    @required String registration,
    CepInfoModel address,
  }) : super(
          id: id,
          name: name,
          registration: registration,
          address: address,
        );

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      registration: json['registration'],
      address: CepInfoModel.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registration': registration,
    };
  }
}

import 'package:healthsup/features/patient/data/models/cep_info_model.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:meta/meta.dart';

class PatientModel extends Patient {
  PatientModel({
    @required int id,
    @required String name,
    @required String registration,
    @required CepInfoModel addressInfo,
  }) : super(
            id: id,
            name: name,
            registration: registration,
            addressInfo: addressInfo);

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      registration: json['registration'],
      addressInfo: CepInfoModel.fromJson(json['Address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registration': registration,
      'Address': addressInfo,
    };
  }
}

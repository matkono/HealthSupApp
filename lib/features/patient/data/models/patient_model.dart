import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:meta/meta.dart';

class PatientModel extends Patient {
  PatientModel({
    @required int id,
    @required String name,
    @required String registration,
    @required String endereco,
  }) : super(
            id: id, name: name, registration: registration, endereco: endereco);

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      registration: json['registration'],
      endereco: json['endereco'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registration': registration,
      'endereco': endereco,
    };
  }
}

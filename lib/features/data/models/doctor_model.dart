import 'package:cardiompp/features/domain/entities/doctor.dart';
import 'package:meta/meta.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    @required String name,
    @required String crm,
    @required String phone,
    @required String email,
    @required String status,
  }) : super(name: name, crm: crm, phone: phone, email: email, status: status);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      crm: json['crm'],
      phone: json['phone'],
      email: json['email'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'crm': crm,
      'phone': phone,
      'email': email,
      'status': status,
    };
  }
}

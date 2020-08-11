import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:meta/meta.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    String name,
    @required String crm,
    String phone,
    @required String email,
    @required bool isActive,
  }) : super(name: name, crm: crm, phone: phone, email: email, isActive: isActive);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      crm: json['crm'],
      phone: json['phone'],
      email: json['email'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'crm': crm,
      'phone': phone,
      'email': email,
      'isActive': isActive,
    };
  }
}

import 'package:mobilecache/features/domain/entities/doctor.dart';
import 'package:meta/meta.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    String name,
    @required String crm,
    String phone,
    @required String email,
    // @required String password,
    String status,
  }) : super(name: name, crm: crm, phone: phone, email: email, status: status);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      crm: json['crm'],
      phone: json['phone'],
      email: json['email'],
      // password: json['password'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'crm': crm,
      'phone': phone,
      'email': email,
      // 'password': password,
      'status': status,
    };
  }
}

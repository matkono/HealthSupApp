import 'package:meta/meta.dart';
import 'package:mobilecache/features/data/models/doctor_model.dart';
import 'package:mobilecache/features/domain/entities/login.dart';

class LoginModel extends Login {
  final DoctorModel doctor;
  final bool success;
  final String error;

  LoginModel({
    @required this.doctor,
    @required this.success,
    @required this.error,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      doctor: DoctorModel.fromJson(json['data']),
      success: json['success'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor,
      'success': success,
      'error': error,
    };
  }
}
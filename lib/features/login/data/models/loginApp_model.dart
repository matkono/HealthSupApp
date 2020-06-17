import 'package:cardiompp/features/login/domain/entities/loginApp.dart';
import 'package:meta/meta.dart';

class LoginDoctorModel extends LoginApp {
  LoginDoctorModel({
    @required String email,
    @required String password,
  }) : super(email: email, password: password);

  factory LoginDoctorModel.fromJson(Map<String, dynamic> json) {
    return LoginDoctorModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password
    };
  }
}

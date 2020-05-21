import 'package:cardiompp/features/domain/entities/login.dart';
import 'package:meta/meta.dart';

class LoginAPIModel extends Login {

  final String agentName;
  final String password;

  LoginAPIModel({
    @required this.agentName,
    @required this.password,
  });

  factory LoginAPIModel.fromJson(Map<String, dynamic> json) {
    return LoginAPIModel(
      agentName: json['agentName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agentName': agentName,
      'password': password,
    };
  }
}
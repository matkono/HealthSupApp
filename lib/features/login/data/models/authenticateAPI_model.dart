import 'package:cardiompp/features/login/domain/entities/authenticate.dart';
import 'package:meta/meta.dart';

class AuthenticateApiModel extends Authenticate {

  final String agentName;
  final String password;

  AuthenticateApiModel({
    @required this.agentName,
    @required this.password,
  });

  factory AuthenticateApiModel.fromJson(Map<String, dynamic> json) {
    return AuthenticateApiModel(
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
import 'package:healthsup/features/login/domain/entities/authenticate.dart';
import 'package:meta/meta.dart';

class AuthenticateApiModel extends Authenticate {
  final String agentKey;
  final String password;

  AuthenticateApiModel({
    @required this.agentKey,
    @required this.password,
  });

  factory AuthenticateApiModel.fromJson(Map<String, dynamic> json) {
    return AuthenticateApiModel(
      agentKey: json['agentKey'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agentKey': agentKey,
      'password': password,
    };
  }
}

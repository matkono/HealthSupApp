import 'package:HealthSup/core/authentication/entities/authentication.dart';
import 'package:flutter/material.dart';

class AuthenticationModel extends Authentication {
  AuthenticationModel({
    @required String agentKey,
    @required String password,
  }) : super(agentKey: agentKey, password: password);

  Map<String, dynamic> toJson() {
    return {
      'agentKey': agentKey,
      'password': password,
    };
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Authentication extends Equatable {
  final String agentKey;
  final String password;

  Authentication({
    @required this.agentKey,
    @required this.password,
  });

  @override
  List<Object> get props => [agentKey, password];
}
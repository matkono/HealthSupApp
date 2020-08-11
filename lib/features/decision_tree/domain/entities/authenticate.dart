import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Authenticate extends Equatable {
  final String agentName;
  final String password;

  Authenticate({
    @required this.agentName,
    @required this.password,
  });

  @override
  List<Object> get props => [agentName, password];
}
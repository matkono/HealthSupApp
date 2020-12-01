import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Authenticate extends Equatable {
  final String agentKey;
  final String password;

  Authenticate({
    @required this.agentKey,
    @required this.password,
  });

  @override
  List<Object> get props => [agentKey, password];
}
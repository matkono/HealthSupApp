import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String agentName;
  final String password;

  Login({
    @required this.agentName,
    @required this.password,
  });

  @override
  List<Object> get props => [agentName, password];
}

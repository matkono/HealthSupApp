import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LoginApp extends Equatable {
  final String email;
  final String password;


  LoginApp({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
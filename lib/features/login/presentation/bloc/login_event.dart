part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SignInEvent extends LoginEvent {
  final String email;
  final String password;

  SignInEvent({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class ResetPasswordEvent extends LoginEvent {
  final String email;
  final String crm;

  ResetPasswordEvent({
    @required this.email,
    @required this.crm,
  });

  @override
  List<Object> get props => [email, crm];
}
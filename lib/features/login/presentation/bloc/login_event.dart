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
  final String password;
  final String newPassword;
  final String confirmNewPassword;

  ResetPasswordEvent({
    @required this.email,
    @required this.password,
    @required this.newPassword,
    @required this.confirmNewPassword,
  });

  @override
  List<Object> get props => [email, password, newPassword, confirmNewPassword];
}

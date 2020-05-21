part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStartState extends LoginState {

  @override
  List<Object> get props => null;
}

class LoginSuccessState extends LoginState {
  final Doctor doctorState;

  LoginSuccessState({this.doctorState});
  @override
  List<Object> get props => [doctorState];
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({this.message});

  @override
  List<Object> get props => [message];
}
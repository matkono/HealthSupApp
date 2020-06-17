part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => ['Iniciando a consulta'];
}

class LoginStartState extends LoginState {

  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final String loggedIn = 'Usuário logado';

  @override
  List<Object> get props => [loggedIn];
}

class LoginIsLoading extends LoginState {
  final String isLoading = 'Loading';

  @override
  List<Object> get props => [isLoading];
}

class LoginEmptyErrorState extends LoginState {
  final String message1 = 'Preencha os campos corretamente';

  @override
  List<Object> get props => [message1];
}

class LoginErrorState extends LoginState {
  final String message2 = 'Email ou Senha inválidos';

  @override
  List<Object> get props => [message2];
}
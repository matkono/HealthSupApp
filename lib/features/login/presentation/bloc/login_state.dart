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
  final String message2;

  LoginErrorState({@required this.message2});

  @override
  List<Object> get props => [message2];
}

class SearchSuccessState extends LoginState {
  @override
  List<Object> get props => [];
}

class SearchErrorState extends LoginState {
  @override
  List<Object> get props => ['Ocorreu um erro!'];
}

class UpdatePasswordSuccessState extends LoginState {
  final String message;

  UpdatePasswordSuccessState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UpdatePasswordErrorState extends LoginState {
  final String message;

  UpdatePasswordErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

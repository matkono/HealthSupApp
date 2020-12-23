import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/features/login/domain/usecases/login_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  LoginBloc({
    @required this.loginUser,
    initialState,
  }) : super(initialState);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInEvent) {
      try {
        yield LoginStartState();
        if (event.email.isEmpty && event.password.isEmpty) {
          yield LoginEmptyErrorState();
        } else {
          var login = await loginUser(ParamsLogin(
            email: event.email,
            password: event.password,
          ));
          yield login.fold(
            (failure) {
              if (failure is ServerFailure)
                return LoginErrorState(message2: failure.failureMessage);
              else
                return LoginErrorState(message2: "Email ou Senha inválidos");
            },
            (success) => LoginSuccessState(),
          );
        }
      } catch (e) {
        yield LoginErrorState(message2: "Email ou Senha inválidos");
        print(e);
      }
    }
  }
}
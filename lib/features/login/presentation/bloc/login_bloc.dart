import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/login/domain/usecases/login_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/login/domain/usecases/update_password.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final UpdatePassword updatePassword;
  LoginBloc({
    @required this.loginUser,
    @required this.updatePassword,
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
    } else if (event is ResetPasswordEvent) {
      try {
        yield LoginIsLoading();
        if (event.email.isEmpty &&
            event.password.isEmpty &&
            event.newPassword.isEmpty &&
            event.confirmNewPassword.isEmpty) {
          yield LoginEmptyErrorState();
        } else {
          var updatePass = await updatePassword(ParamsUpdatePassword(
            email: event.email,
            password: event.password,
            newPassword: event.newPassword,
            confirmNewPassword: event.confirmNewPassword,
          ));
          yield updatePass.fold(
            (failure) {
              if (failure is ServerFailure)
                return UpdatePasswordErrorState(
                    message: failure.failureMessage);
              else
                return UpdatePasswordErrorState(
                    message: "Email ou Senha inválidos");
            },
            (success) =>
                UpdatePasswordSuccessState(message: 'Nova senha redefinida!'),
          );
        }
      } catch (e) {
        yield UpdatePasswordErrorState(message: "Ocorreu um erro!");
        print(e);
      }
    }
  }
}

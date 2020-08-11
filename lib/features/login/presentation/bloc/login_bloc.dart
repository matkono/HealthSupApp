import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:HealthSup/features/login/domain/usecases/loginApp_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInEvent) {
      try {
        yield LoginStartState();
        final validate = await validateLogin(event.email, event.password);

        if (validate == true) {
          yield LoginEmptyErrorState();
        } else {
          final login = await authenticateLogin(event.email, event.password);

          if (login.isRight() == true) {
            yield LoginSuccessState();
          } else {
            yield LoginErrorState();
          }
        }
      } catch (e) {
        yield LoginErrorState();
        print(e);
      }
    }
  }

  Future<Either<Failure, Doctor>> authenticateLogin(String email, String password) {
    return Future.delayed(Duration(seconds: 2), () async {
      LoginAppUseCase verifyData = LoginAppUseCase();

      final result = await verifyData.call(Params(email: email, password: password));

      print("<<< AuthenticationAPI >>>");

      return result;
    });
  }

  Future<bool> validateLogin(String email, String password) async {
    print("<<< validating Login Form >>>");

    if(email.isEmpty && password.isEmpty) {
      print('Login format: ERROR');
      return true;
    }
    print('Login format: OK');
    return false;
  }
}
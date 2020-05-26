import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cardiompp/features/domain/entities/doctor.dart';
import 'package:cardiompp/features/domain/usecases/doctor_usecase.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInEvent) {
      try {
        yield LoginStartState();
        final doctor =
            await authenticateLogin(event.email, event.password);

        if (doctor == null) {
          yield LoginErrorState(message: "Email or password incorrect");
        } else {
          yield LoginSuccessState(doctorState: doctor);
        }
      } catch (e) {
        yield LoginErrorState(message: 'Oops, Something went wrong!');
        print(e);
      }
    }
  }

  Future<Doctor> authenticateLogin(String email, String password) {
    return Future.delayed(Duration(seconds: 2), () async {
      DoctorUseCase verifyData = DoctorUseCase();
      print("<<< AuthenticationAPI >>>");

      final bool result = await verifyData.call(Params(email: email, password: password));

      if(result) {
        return Doctor(email: email);
      }
      
      return null;
    });
  }
}

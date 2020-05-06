import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mobilecache/features/domain/entities/doctor.dart';
import 'package:mobilecache/features/domain/usecases/get_doctor_data.dart';
import 'bloc.dart';

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
            await authenticateLogin(event.crm, event.email, event.password);

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

  Future<Doctor> authenticateLogin(String crm, String email, String password) {
    return Future.delayed(Duration(seconds: 2), () async {
      GetDoctorLogin verifyData = GetDoctorLogin();
      print("anthentication");

      final bool result = await verifyData.call(Params(crm: crm, email: email, password: password));
      
      print('Result Bloc');
      print(result);

      if(result) {
        return Doctor(crm: crm, email: email);
      }
      
      return null;
    });
  }
}

import 'package:cardiompp/features/presentation/pages/loged_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/blocs/login_bloc/login_bloc.dart';
import 'features/presentation/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Challenge',
      routes: <String, WidgetBuilder>{
        LogedPage.routeName: (context) =>
          LogedPage(title: 'Loged in Mobile TCC'),
        LoginPage.routeName: (context) => LoginPage(),

      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
        ],
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if(state is LoginStartState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is LoginErrorState) {
              return LoginPage(errorMessage: state.message);
            }
            if(state is LoginSuccessState) {
              return LogedPage(doctor: state.doctorState);
            }
            return LoginPage();
          },  
        ),
      )
    );
  }
}
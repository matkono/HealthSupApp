import 'package:cardiompp/features/login/presentation/pages/loged_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/login/presentation/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc> (
      create: (BuildContext context) {
        return LoginBloc();
      },
      child: MaterialApp(
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginPage(),
          '/logged': (context) => LogedPage(),
        },
      ),
    );
  }
}
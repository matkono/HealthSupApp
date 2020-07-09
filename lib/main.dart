import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'features/decision_tree/presentation/pages/medical_appointment.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/login/presentation/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return BlocProvider<LoginBloc> (
    //   create: (BuildContext context) {
    //     return LoginBloc();
    //   },
    return BlocProvider<DecisionTreeBloc> (
      create: (BuildContext context) {
        return DecisionTreeBloc();
      },
      child: MaterialApp(
        home: MedicalAppointment(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: Colors.black),
        routes: {
          '/login': (context) => LoginPage(),
          '/logged': (context) => MedicalAppointment(),
        },
      ),
    );
  }
}
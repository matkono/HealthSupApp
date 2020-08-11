import 'package:HealthSup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:HealthSup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:HealthSup/features/login/presentation/bloc/login_bloc.dart';
import 'package:HealthSup/features/login/presentation/pages/login_page.dart';
import 'package:HealthSup/features/tutorial/presentation/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(LoginInitial()),
        ),
        BlocProvider<DecisionTreeBloc>(
          create: (context) => DecisionTreeBloc(initialState: DecisionTreeInitial()),
        ),
      ],
      child: MaterialApp(
        home: BasePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/logged': (context) => MedicalAppointment(),
        },
      ),
    );
  }
}
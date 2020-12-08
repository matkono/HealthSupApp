

import 'package:HealthSup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:HealthSup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:HealthSup/features/login/presentation/bloc/login_bloc.dart';
import 'package:HealthSup/features/login/presentation/pages/login.dart';
import 'package:HealthSup/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:HealthSup/features/patient/presentation/overlays/pages/overlay.dart';
import 'package:HealthSup/features/patient/presentation/overlays/pages/overlay_patient_details.dart';
import 'package:HealthSup/features/patient/presentation/pages/patient_homepage.dart';
import 'package:HealthSup/features/patient/presentation/widgets/patient_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PatientBloc>(
          create: (context) => PatientBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(LoginInitial()),
        ),
        BlocProvider<DecisionTreeBloc>(
          create: (context) => di.sl<DecisionTreeBloc>(),
        ),
      ],
      child: MaterialApp(
        home: PatientHomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => PatientHomePage(),
          '/medicalAppointment': (context) => MedicalAppointment(),
          '/overlayPatientHomePage': (context) => OverlayHomePage(),
          '/overlayPatientDetails': (context) => OverlayPatientDetails(),
          '/patientDetails': (context) => PatientDetails(),
        },
      ),
    );
  }
}
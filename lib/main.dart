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
import 'package:responsive_framework/responsive_framework.dart';
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
          create: (context) => di.sl<LoginBloc>(),
        ),
        BlocProvider<DecisionTreeBloc>(
          create: (context) => di.sl<DecisionTreeBloc>(),
        ),
      ],
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: false,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(
            color: Color(0xFFF5F5F5),
          ),
        ),
        home: LoginPage(),
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

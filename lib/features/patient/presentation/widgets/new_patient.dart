import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:healthsup/features/patient/presentation/widgets/patient_form.dart';

class NewPatient extends StatefulWidget {
  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  Widget _buildBody(BuildContext context, Patient patient) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: PatientForm(
            patient: patient,
          ),
        ),
        Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PatientBloc, PatientState>(
          builder: (BuildContext context, PatientState state) {
        if (state is LoadedPatientState) {
          return _buildBody(context, state.patient);
        } else if (state is LoadingPatientState) {
          return Center(
            child: Text('Deveria ter um Loading'),
          );
        } else if (state is ErrorPatientState) {
          return _buildBody(context, state.patient);
        }
      }),
    );
  }
}

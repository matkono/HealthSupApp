import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:healthsup/features/registration/presentation/widgets/patient_form.dart';

class NewPatient extends StatefulWidget {
  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  Widget _buildBody(
      BuildContext context, RegisterPatientEntity registerPatient) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: PatientForm(
            registerPatient: registerPatient,
          ),
        ),
        Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (BuildContext context, RegistrationState state) {
        if (state is RegistrationInitial) {
          return SingleChildScrollView(child: PatientForm());
        } else if (state is LoadedRegistrationState) {
          return _buildBody(context, state.registerPatient);
        } else if (state is LoadingRegistrationState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorRegistrationState) {
          return _buildBody(context, state.registerPatient);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

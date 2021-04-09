import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/patient/presentation/bloc/patient_bloc.dart'
    as patient_bloc;
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/presentation/bloc/registration_bloc.dart';
import 'package:healthsup/features/registration/presentation/widgets/patient_form.dart';
import 'package:healthsup/features/registration/presentation/widgets/update_patient_form.dart';

class NewPatient extends StatefulWidget {
  final int type;
  final int patientID;

  const NewPatient({
    Key key,
    @required this.type,
    this.patientID,
  }) : super(key: key);
  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  Widget _buildBody(
      BuildContext context, RegisterPatientEntity registerPatient) {
    return Stack(
      children: <Widget>[
        PatientForm(
          registerPatient: registerPatient,
        ),
        Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          print('registration: $state');
          if (state is LoadedRegistryState) {
            BlocProvider.of<patient_bloc.PatientBloc>(context).add(
              patient_bloc.SearchPatientEvent(
                registration: state.registerPatientEntity.registration,
              ),
            );
            Navigator.pop(context);
          } else if (state is LoadedUpdateState) {
            BlocProvider.of<patient_bloc.PatientBloc>(context).add(
              patient_bloc.GetPatientInfoEvent(
                registration: state.registerPatientEntity.registration,
              ),
            );
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (BuildContext context, RegistrationState state) {
            print('registration_builder: $state');
            if (state is RegistrationInitial) {
              if (widget.type == 1) {
                return PatientForm();
              } else {
                return UpdatePatientForm();
              }
            } else if (state is LoadingRegistrationState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorRegistrationState) {
              return _buildBody(context, state.registerPatient);
            } else if (state is LoadedCepRegistryState) {
              return PatientForm(
                registerPatient: state.registerPatient,
              );
            } else if (state is LoadedCepUpdateState) {
              return UpdatePatientForm(
                registerPatient: state.registerPatient,
              );
            } else {
              if (widget.type == 1) {
                return PatientForm();
              } else {
                return UpdatePatientForm();
              }
            }
          },
        ),
      ),
    );
  }
}

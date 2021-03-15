import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/disease/presentation/bloc/disease_bloc.dart';
import 'package:healthsup/features/disease/presentation/widgets/list_disease.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';

class DiseaseHomePage extends StatefulWidget {
  final Patient patient;

  const DiseaseHomePage({
    Key key,
    @required this.patient,
  }) : super(key: key);
  @override
  _DiseaseHomePageState createState() => _DiseaseHomePageState();
}

class _DiseaseHomePageState extends State<DiseaseHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DiseaseBloc, DiseaseState>(
        builder: (context, state) {
          if (state is DiseaseLoaded) {
            return ListDisease(
              patient: widget.patient,
              diseasesList: state.diseasesList,
              totalRows: state.totalRows,
            );
          } else if (state is DiseaseLoading) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/disease/presentation/bloc/disease_bloc.dart';
import 'package:healthsup/features/disease/presentation/widgets/list_disease.dart';

class DiseaseHomePage extends StatefulWidget {
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

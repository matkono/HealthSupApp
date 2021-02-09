import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:healthsup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartDecisionTree extends StatelessWidget {
  const StartDecisionTree({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 50),
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.bottomCenter,
      child: FlatButton(
        color: Colors.blue,
        child: Text(
          'Nova Consulta',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          BlocProvider.of<DecisionTreeBloc>(context)
              .add(StartDecisionTreeEvent());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicalAppointment()),
          );
        },
      ),
    );
  }
}

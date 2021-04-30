import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';

class ErrorLayout extends StatelessWidget {
  final int idAppointment;
  const ErrorLayout({
    Key key,
    @required this.idAppointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            child: Center(
              child: FlatButton(
                height: MediaQuery.of(context).size.width / 10,
                color: Colors.blue,
                child: Text(
                  'Recarregar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<DecisionTreeBloc>(context).add(
                      GetCurrentNodeDecisionTreeEvent(
                          idAppointmment: idAppointment));
                },
              ),
            ),
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 1,
          ),
        ),
      ],
    );
  }
}

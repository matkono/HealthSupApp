import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorLayout extends StatelessWidget {
  const ErrorLayout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Container(
            child: Center(
              child: Text(BlocProvider.of<DecisionTreeBloc>(context)
                  .state
                  .props
                  .toString()),
            ),
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width / 1,
          ),
        ),
      ],
    );
  }
}

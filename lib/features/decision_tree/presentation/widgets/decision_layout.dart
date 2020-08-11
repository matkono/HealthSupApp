import 'package:HealthSup/features/decision_tree/domain/entities/answer.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:HealthSup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DecisionLayout extends StatelessWidget {
  final Node node;

  const DecisionLayout({
    Key key,
    @required this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                node.decision.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 1.3,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, right: 20),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Voltar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  (node.nodeTypeCode == 300 &&
                          node.question.questionCode == 1)
                      ? BlocProvider.of<DecisionTreeBloc>(context).add(InitialDecisionTreeEvent())
                      : BlocProvider.of<DecisionTreeBloc>(context).add(StartDecisionTreeEvent());
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: FlatButton(
                color: Colors.blue,
                child: Text('Avançar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<DecisionTreeBloc>(context).add(NextNodeDecisionTreeEvent(
                      answer: Answer(answers: null)));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

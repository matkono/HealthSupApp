import 'package:HealthSup/features/decision_tree/domain/entities/answer.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:HealthSup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxQuestion extends StatefulWidget {
  final Node node;

  const CheckBoxQuestion({
    Key key,
    @required this.node,
  }) : super(key: key);

  @override
  _CheckBoxQuestionState createState() => _CheckBoxQuestionState();
}

class _CheckBoxQuestionState extends State<CheckBoxQuestion> {
  Answer finalAnswer = new Answer(answers: []);
  int index;
  Map<PossibleAnswer, bool> mapAnswer = {};

  Widget radioAnswer(BuildContext context, List<PossibleAnswer> possibleAnswers, Answer answer) {

    if (mapAnswer.isEmpty)
      for (index = 0; index < possibleAnswers.length; index++) {
        mapAnswer.addAll({
          PossibleAnswer(id: possibleAnswers[index].id, value: possibleAnswers[index].value): false,
        });
      }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        itemCount: possibleAnswers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(possibleAnswers[index].value),
            leading: Checkbox(
              value: mapAnswer[PossibleAnswer(id: possibleAnswers[index].id, value: possibleAnswers[index].value)],
              onChanged: (value) {
                setState(() {
                  mapAnswer[PossibleAnswer(id: possibleAnswers[index].id, value: possibleAnswers[index].value)] = value;

                  (value)
                  ? answer.answers.add(possibleAnswers[index])
                  : answer.answers.remove(possibleAnswers[index]);
                });
              },
            ),
          );
        },
      ),
    );
  }

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
                widget.node.question.title,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 1.5,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: radioAnswer(
              context, widget.node.question.possibleAnswers, finalAnswer),
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
                  BlocProvider.of<DecisionTreeBloc>(context)
                      .add(InitialDecisionTreeEvent());
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
                  BlocProvider.of<DecisionTreeBloc>(context).add(
                    NextNodeDecisionTreeEvent(
                      answer: Answer(answers: finalAnswer.answers)));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

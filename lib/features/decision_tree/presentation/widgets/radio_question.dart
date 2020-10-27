import 'package:HealthSup/features/decision_tree/domain/entities/answer.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:HealthSup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioQuestionLoaded extends StatefulWidget {
  final Node node;

  const RadioQuestionLoaded({
    Key key,
    @required this.node,
    }) : super(key: key);

  @override
  _RadioQuestionLoadedState createState() => _RadioQuestionLoadedState();

}

class _RadioQuestionLoadedState extends State<RadioQuestionLoaded> {
  int radioButton = 0;
  Answer finalAnswer = new Answer(answers: []);
  Map<PossibleAnswer, int> mapAnswer = {};

  Widget radioAnswer(BuildContext context, List<PossibleAnswer> possibleAnswers, Answer answer) {

    if (answer.answers.isEmpty) {
      mapAnswer.addAll({
        PossibleAnswer(id: possibleAnswers[0].id, value: possibleAnswers[0].value): 0});
      answer.answers.add(possibleAnswers[0]);

      for (int x = 1; x < possibleAnswers.length; x++) {
        mapAnswer.addAll({
          PossibleAnswer(id: possibleAnswers[x].id, value: possibleAnswers[x].value): x});
      }
    }
    
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        itemCount: possibleAnswers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(possibleAnswers[index].value),
            leading: Radio(
              value: mapAnswer[PossibleAnswer(id: possibleAnswers[index].id, value: possibleAnswers[index].value)],
              groupValue: radioButton,
              onChanged: (value) {
                setState(() {
                  print('radioButton BEFORE: $radioButton');
                  print('value: $value');
                  print('index: $index');
                  radioButton = value;
                  print('radioButton AFTER: $radioButton');
                  print('');
                  answer.answers.removeLast();
                  answer.answers.add(possibleAnswers[index]);
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
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),
            alignment: Alignment.topCenter,
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
                  BlocProvider.of<DecisionTreeBloc>(context).add(InitialDecisionTreeEvent());
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
                    print('id: ${finalAnswer.answers[0].id} | value: ${finalAnswer.answers[0].value}');
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
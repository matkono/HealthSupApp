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
  Map<PossibleAnswer, int> mapAnswer = {};
  Answer finalAnswer = new Answer(
    medicalAppointmentId: null,
    doctorId: null,
    questionId: null,
    possibleAnswerGroupId: null,
    date: null,
    possibleAnswers: [],
  );

  Widget radioAnswer(
    BuildContext context,
    List<PossibleAnswer> possibleAnswers,
    Answer answer,
  ) {
    if (answer.possibleAnswers.isEmpty) {
      mapAnswer.addAll({
        PossibleAnswer(
          id: possibleAnswers[0].id,
          code: possibleAnswers[0].code,
          title: possibleAnswers[0].title,
          possibleAnswerGroupId: possibleAnswers[0].possibleAnswerGroupId,
        ): 0
      });
      answer.possibleAnswers.add(possibleAnswers[0]);

      for (int x = 1; x < possibleAnswers.length; x++) {
        mapAnswer.addAll({
          PossibleAnswer(
            id: possibleAnswers[x].id,
            code: possibleAnswers[x].code,
            title: possibleAnswers[x].title,
            possibleAnswerGroupId: possibleAnswers[x].possibleAnswerGroupId,
          ): x
        });
      }
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        itemCount: possibleAnswers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(possibleAnswers[index].title),
            leading: Radio(
              value: mapAnswer[PossibleAnswer(
                id: possibleAnswers[index].id,
                code: possibleAnswers[index].code,
                title: possibleAnswers[index].title,
                possibleAnswerGroupId:
                    possibleAnswers[index].possibleAnswerGroupId,
              )],
              groupValue: radioButton,
              onChanged: (value) {
                setState(() {
                  radioButton = value;
                  answer.possibleAnswers.removeLast();
                  answer.possibleAnswers.add(possibleAnswers[index]);
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
    return Expanded(
      child: Column(
        children: [
          AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              'Cardiomiopatia Periparto',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            backgroundColor: Colors.grey[300],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/prancheta2.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4.5,
                    child: Center(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          widget.node.question.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: radioAnswer(context,
                        widget.node.question.possibleAnswers, finalAnswer),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 50, right: 20),
                            child: FlatButton(
                              color: widget.node.isInitial
                                  ? Colors.grey
                                  : Colors.blue,
                              child: Text(
                                'Voltar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                if (!widget.node.isInitial) {
                                  BlocProvider.of<DecisionTreeBloc>(context)
                                      .add(
                                    GetPreviousNodeDecisionTreeEvent(
                                      idNode: widget.node.id,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50, left: 20),
                            child: FlatButton(
                              color: Colors.blue,
                              child: Text(
                                'Avançar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                print(
                                    'id: ${finalAnswer.possibleAnswers[0].id} | value: ${finalAnswer.possibleAnswers[0].title}');
                                BlocProvider.of<DecisionTreeBloc>(context).add(
                                  GetNextNodeDecisionTreeEvent(
                                    answer: Answer(
                                      medicalAppointmentId: 1,
                                      doctorId: 1,
                                      questionId: widget.node.question.id,
                                      possibleAnswerGroupId: mapAnswer.entries
                                          .firstWhere(
                                              (e) => e.value == radioButton)
                                          .key
                                          .possibleAnswerGroupId,
                                      date: DateTime.now(),
                                      possibleAnswers: [
                                        mapAnswer.entries
                                            .firstWhere(
                                                (e) => e.value == radioButton)
                                            .key
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

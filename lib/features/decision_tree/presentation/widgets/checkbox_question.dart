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
  int groupId;
  int index;
  List<PossibleAnswer> possibleAnswersResult = [];
  Map<PossibleAnswer, bool> mapAnswer = {};
  Answer finalAnswer = new Answer(
      medicalAppointmentId: null,
      doctorId: null,
      questionId: null,
      possibleAnswerGroupId: null,
      date: null,
      possibleAnswers: []);

  Widget checkBoxAnswer(BuildContext context,
      List<PossibleAnswer> possibleAnswers, Answer answer2) {
    if (mapAnswer.isEmpty)
      for (index = 0; index < possibleAnswers.length; index++) {
        mapAnswer.addAll({
          PossibleAnswer(
            id: possibleAnswers[index].id,
            code: possibleAnswers[index].code,
            title: possibleAnswers[index].title,
            possibleAnswerGroupId: possibleAnswers[index].possibleAnswerGroupId,
          ): false,
        });
      }

    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        itemCount: possibleAnswers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(possibleAnswers[index].title),
            leading: Checkbox(
              value: mapAnswer[PossibleAnswer(
                id: possibleAnswers[index].id,
                code: possibleAnswers[index].code,
                title: possibleAnswers[index].title,
                possibleAnswerGroupId:
                    possibleAnswers[index].possibleAnswerGroupId,
              )],
              onChanged: (value) {
                setState(
                  () {
                    if (value) {
                      groupId = possibleAnswers[index].possibleAnswerGroupId;
                      mapAnswer.entries.forEach(
                        (entry) {
                          if (entry.key.possibleAnswerGroupId == groupId) {
                            mapAnswer[entry.key] = value;
                          } else {
                            mapAnswer[entry.key] = !value;
                          }
                        },
                      );
                    } else {
                      groupId = null;
                      mapAnswer.entries.forEach(
                        (entry) {
                          mapAnswer[entry.key] = false;
                        },
                      );
                    }

                    mapAnswer.entries.forEach(
                      (entry) {
                        if (entry.value) {
                          possibleAnswersResult.add(entry.key);
                        } else {
                          possibleAnswersResult.remove(entry.key);
                        }
                      },
                    );
                  },
                );
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
        children: <Widget>[
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
                    child: checkBoxAnswer(context,
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
                              color: Colors.blue,
                              child: Text(
                                'Voltar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                BlocProvider.of<DecisionTreeBloc>(context).add(
                                    GetPreviousNodeDecisionTreeEvent(
                                        idNode: widget.node.id));
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
                                BlocProvider.of<DecisionTreeBloc>(context).add(
                                  GetNextNodeDecisionTreeEvent(
                                    answer: Answer(
                                      medicalAppointmentId: 1,
                                      doctorId: 1,
                                      questionId: widget.node.question.id,
                                      possibleAnswerGroupId: groupId,
                                      date: DateTime.now(),
                                      possibleAnswers: possibleAnswersResult,
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

import 'package:healthsup/features/decision_tree/domain/entities/answer.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/domain/entities/possible_answer.dart';
import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxQuestion extends StatefulWidget {
  final Node node;
  final int idAppointment;

  const CheckBoxQuestion({
    Key key,
    @required this.node,
    @required this.idAppointment,
  }) : super(key: key);

  @override
  _CheckBoxQuestionState createState() => _CheckBoxQuestionState();
}

class _CheckBoxQuestionState extends State<CheckBoxQuestion> {
  int groupId;
  int index;
  int possibleAnswersId;
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
                    groupId = possibleAnswers[index].possibleAnswerGroupId;
                    possibleAnswersId = possibleAnswers[index].id;
                    if (value == true) {
                      mapAnswer.entries.forEach(
                        (entry) {
                          if (entry.key.possibleAnswerGroupId == groupId &&
                              entry.key.id == possibleAnswersId) {
                            mapAnswer[entry.key] = value;
                            if ((mapAnswer[entry.key] == true) &&
                                (entry.key.possibleAnswerGroupId == groupId)) {
                              if (possibleAnswersResult.isNotEmpty) {
                                possibleAnswersResult.removeWhere((entry) =>
                                    entry.possibleAnswerGroupId != groupId);
                              }
                            }
                            if ((mapAnswer[entry.key] == true) &&
                                (entry.key.possibleAnswerGroupId == groupId)) {
                              possibleAnswersResult.add(entry.key);
                            }
                          } else {
                            if (mapAnswer[entry.key] == true &&
                                entry.key.possibleAnswerGroupId == groupId) {
                              mapAnswer[entry.key] = true;
                            } else {
                              mapAnswer[entry.key] = !value;
                            }
                          }
                        },
                      );
                    } else {
                      mapAnswer.entries.forEach(
                        (entry) {
                          if (entry.key.possibleAnswerGroupId == groupId &&
                              entry.key.id == possibleAnswersId) {
                            mapAnswer[entry.key] = value;
                            possibleAnswersResult.remove(entry.key);
                          }
                        },
                      );
                    }
                    print(possibleAnswersResult);
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
            leading: Navigator.canPop(context)
                ? IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 47,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                : null,
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
                    height: MediaQuery.of(context).size.height / 4.0,
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
                            margin: EdgeInsets.only(top: 30, right: 20),
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
                                      idAppointment: widget.idAppointment,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30, left: 20),
                            child: FlatButton(
                              color: (possibleAnswersResult == null ||
                                      (possibleAnswersResult.isEmpty))
                                  ? Colors.grey
                                  : Colors.blue,
                              child: Text(
                                'Avançar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (possibleAnswersResult != null &&
                                    possibleAnswersResult.isNotEmpty) {
                                  BlocProvider.of<DecisionTreeBloc>(context)
                                      .add(
                                    GetNextNodeDecisionTreeEvent(
                                      answer: Answer(
                                        medicalAppointmentId:
                                            widget.idAppointment,
                                        doctorId: 1,
                                        questionId: widget.node.question.id,
                                        possibleAnswerGroupId: groupId,
                                        date: DateTime.now(),
                                        possibleAnswers: possibleAnswersResult,
                                      ),
                                    ),
                                  );
                                }
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

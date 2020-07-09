import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/possible_Answer.dart';
import 'package:cardiompp/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalAppointment extends StatefulWidget {
  final String title;

  MedicalAppointment({Key key, this.title}) : super(key: key);

  @override
  _MedicalAppointmentState createState() => _MedicalAppointmentState();
}

class _MedicalAppointmentState extends State<MedicalAppointment> {
  DecisionTreeBloc decisionTreeBloc;
  int radioButton = 0;
  final answerTest = new Answer(answers: []);
  bool optionOne  = false;
  bool optionTwo  = false;
  bool optionThree  = false;

  void initState() {
    super.initState();

    decisionTreeBloc = DecisionTreeBloc();
  }

  Widget radioAnswer(BuildContext context, List<PossibleAnswer> possibleAnswers, Answer answer) {
    Map<String, int> finalAnswer =
    {
      "Value": possibleAnswers[1].id,
    };

    (answer.answers.isNotEmpty)
    ? print(answer.answers)
    : answer.answers.add(finalAnswer);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text(possibleAnswers[index].value),
          leading: Radio(
            value: index,
            groupValue: radioButton,
            onChanged: (value) {
              setState(() {
                radioButton = value;
                answer.answers[0]['Value'] = possibleAnswers[index].id;
                print(answer.answers[0]['Value']);
              });
            },
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider<DecisionTreeBloc>(
          create: (BuildContext context) {
            return DecisionTreeBloc();
          },
          child: BlocListener<DecisionTreeBloc, DecisionTreeState>(
            listener: (BuildContext context, state) {
              if (state is IsLoadingDecisionTreeState)
                Text(state.props.toString());
            },
            child: BlocBuilder<DecisionTreeBloc, DecisionTreeState>(
              bloc: decisionTreeBloc,
              builder: (BuildContext context, DecisionTreeState state) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                  children: <Widget>[
                    if (state is DecisionTreeInitial)
                      Container(
                        margin: EdgeInsets.only(top: 362.5),
                        alignment: Alignment.center,
                        child: FlatButton(
                          color: Colors.blue[300],
                          child: Text('Nova Consulta'),
                          onPressed: () {
                            setState(() {
                              decisionTreeBloc.add(StartDecisionTreeEvent());
                            });
                          },
                        ),
                      ),
                    if (state is LoadedDecisionTreeState)
                      (state.node.nodeTypeCode == 300 && state.node.question.questionTypeCode == 100)
                        ? Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    state.node.question.title,
                                    style: TextStyle(
                                      fontSize: 21,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.topCenter,
                                height:
                                    MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 1,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                              color: Colors.grey,
                              child: radioAnswer(context, state.node.question.possibleAnswers, answerTest),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20, right: 20),
                                    child: FlatButton(
                                      color: Colors.lightBlue[800],
                                      child: Text('Voltar'),
                                      onPressed: () async {
                                        setState(() {
                                          print(state.toString());
                                          decisionTreeBloc.add(InitialDecisionTreeEvent());
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20, left: 20),
                                    child: FlatButton(
                                      color: Colors.lightBlue[800],
                                      child: Text('Avançar'),
                                      onPressed: () {
                                        setState(() {
                                          print('ta aqui');
                                          print(answerTest.answers);
                                          print(state.node.question.possibleAnswers[0].value);
                                          decisionTreeBloc.add(
                                              NextNodeDecisionTreeEvent(
                                                // answer: Answer(code: state.node.question.possibleAnswers[0].id)));
                                                answer: Answer(answers: null)));
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                        : (state.node.nodeTypeCode == 301)
                        ? Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                              child: Container(
                                padding: EdgeInsets.only(left: 40),
                                margin: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    state.node.decision.title,
                                    style: TextStyle(
                                      fontSize: 21,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.topCenter,
                                height:
                                    MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 1,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20, right: 20),
                                    child: FlatButton(
                                      color: Colors.lightBlue[800],
                                      child: Text('Voltar'),
                                      onPressed: () async {
                                        setState(() {
                                          print(state.toString());
                                          print(state.node.nodeTypeCode);
                                          (state.node.nodeTypeCode == 300 && state.node.question.questionCode == 1)
                                          ? decisionTreeBloc.add(InitialDecisionTreeEvent())
                                          : decisionTreeBloc.add(StartDecisionTreeEvent());
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20, left: 20),
                                    child: FlatButton(
                                      color: Colors.lightBlue[800],
                                      child: Text('Avançar'),
                                      onPressed: () {
                                        setState(() {
                                          print(state.toString());
                                          print(state.node.question.possibleAnswers[0].value);
                                          decisionTreeBloc.add(
                                              NextNodeDecisionTreeEvent(
                                                answer: Answer(answers: null)));
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        )
                        : Text('Data'),
                    if (state is ErrorDecisionTreeState)
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                  top: 25, left: 20, right: 20),
                            child: Container(
                              child: Center(
                                  child: Text(state.props.toString()),
                              ),
                              alignment: Alignment.topCenter,
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width / 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    if (state is StartDecisionTreeState)
                      (state.node.nodeTypeCode == 300 && state.node.question.questionTypeCode == 100)
                          ? Column(
                              children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 20, right: 20),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                        ],
                                      ),
                                      alignment: Alignment.topCenter,
                                      height: MediaQuery.of(context).size.height / 1.5,
                                      width: MediaQuery.of(context).size.width / 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 20, right: 20),
                                        child: FlatButton(
                                          color: Colors.lightBlue[800],
                                          child: Text('Voltar'),
                                          onPressed: () async {
                                            setState(() {
                                              print(state.toString());
                                              (state.node.question.questionCode == 1)
                                                  ? decisionTreeBloc.add(InitialDecisionTreeEvent())
                                                  : decisionTreeBloc.add(LastNodeDecisionTreeEvent(idQuestion: state.node.question.questionCode));
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 20, left: 20),
                                        child: FlatButton(
                                          color: Colors.lightBlue[800],
                                          child: Text('Avançar'),
                                          onPressed: () {
                                            setState(() {
                                              decisionTreeBloc.add(
                                                  NextNodeDecisionTreeEvent(
                                                    answer: Answer(answers: null)));
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          : Text('data'),
                  ],
                ),
                                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

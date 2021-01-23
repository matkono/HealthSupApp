import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionLayout extends StatefulWidget {
  final Node node;

  const ActionLayout({
    Key key,
    @required this.node,
  }) : super(key: key);

  @override
  _ActionLayoutState createState() => _ActionLayoutState();
}

class _ActionLayoutState extends State<ActionLayout> {
  int radioButton;

  Widget radioAnswer(
    BuildContext context,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(index == 0 ? 'Não' : 'Sim'),
            leading: Radio(
              value: index,
              groupValue: radioButton,
              onChanged: (value) {
                setState(() {
                  radioButton = value;
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
                    margin: EdgeInsets.only(top: 60),
                    child: Center(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '${widget.node.action.title}',
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
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: radioAnswer(context),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 20),
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
                            margin: EdgeInsets.only(left: 20),
                            child: FlatButton(
                              color: radioButton == null
                                  ? Colors.grey
                                  : Colors.blue,
                              child: Text(
                                'Avançar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (radioButton != null) {
                                  if (radioButton == 0) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: Text("Ação necessaria"),
                                          content:
                                              Text(widget.node.action.title),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text("Cancelar"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text("Sair"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (radioButton == 1) {
                                    BlocProvider.of<DecisionTreeBloc>(context)
                                        .add(
                                      ConfirmActionDecisionTreeEvent(
                                        idAction: widget.node.action.id,
                                      ),
                                    );
                                  }
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

import 'package:HealthSup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:HealthSup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:HealthSup/features/patient/presentation/widgets/edit_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  var searchPatient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: Column(
          children: [
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.grey[300],
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  title: Text(
                    '12345678912-1',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20, right: 10),
                      width: MediaQuery.of(context).size.width / 1.70,
                      height: MediaQuery.of(context).size.height / 12,
                      child: Text(
                        'Dados Cadastrais',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPatient()),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/profile.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Text(
                            'Nome: Leandro Shibahara',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 5),
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: Text(
                            'Endereço: Avenida Presidente Juscelino Kubitschek, 901 - Jardim Ypê',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'HISTÓRICO',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 10,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width / 1.6,
                                child: Text(
                                  'Primeira consulta iniciada ou concluída do paciente em questão com data e status',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                color: Colors.blue[600],
                                child: FlatButton(
                                  child: Text(
                                    'Continuar',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<DecisionTreeBloc>(context)
                                        .add(StartDecisionTreeEvent());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MedicalAppointment()),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: RaisedButton(
                    color: Colors.blue[700],
                    child: Text(
                      'Nova Consulta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicalAppointment(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/registration/presentation/bloc/registration_bloc.dart'
    as registration_bloc;
import 'package:healthsup/features/registration/presentation/pages/new_patient.dart';

class PatientHomePageWidget extends StatefulWidget {
  @override
  _PatientHomePageWidgetState createState() => _PatientHomePageWidgetState();
}

class _PatientHomePageWidgetState extends State<PatientHomePageWidget> {
  int registryType = 1;
  var registrationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.grey[300],
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
                actions: [
                  Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: FlatButton(
                      child: Text(
                        'Ajuda',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            '/overlayPatientHomePage', (route) => false);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.grey[300],
                padding: EdgeInsets.only(left: 15),
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        'Bem-vindo, Doutor',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                height: MediaQuery.of(context).size.height / 14,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        'Cadastrar Paciente',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 7.7,
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 35,
                          ),
                          onPressed: () {
                            BlocProvider.of<registration_bloc.RegistrationBloc>(
                                    context)
                                .add(
                              registration_bloc.AddPatientEvent(),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPatient(
                                        type: registryType,
                                      )),
                            );
                          },
                        )),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.transparent,
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/HealthSup-logo-sem-nome-homepage.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.transparent,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 15),
                height: MediaQuery.of(context).size.height / 13,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: registrationController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(
                              Icons.search,
                              color: Colors.blueGrey,
                            ),
                          ),
                          hintText: 'Procurar paciente',
                          hintStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width / 7.7,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 35,
                        ),
                        onPressed: () {
                          BlocProvider.of<PatientBloc>(context).add(
                            SearchPatientEvent(
                              registration: registrationController.text,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

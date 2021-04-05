import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:healthsup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:healthsup/features/disease/presentation/pages/disease.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:healthsup/features/patient/presentation/widgets/edit_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({
    Key key,
  }) : super(key: key);
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  var searchPatient = TextEditingController();
  ScrollController _scrollController =
      new ScrollController(keepScrollOffset: true);

  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchTen();
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void fetchTen() {
    BlocProvider.of<PatientBloc>(context).add(GetNextAppointmentListEvent());
  }

  Widget _infiniteScroll(
    BuildContext context,
    Patient patient,
    List<MedicalAppointment> medicalAppointmentList,
    int totalRows,
  ) {
    if (medicalAppointmentList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemCount: medicalAppointmentList.length + 1,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        if (index == medicalAppointmentList.length) {
          if (index != totalRows) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        }
        return Container(
          child: FlatButton(
            onPressed: () {
              BlocProvider.of<DecisionTreeBloc>(context).add(
                GetCurrentNodeDecisionTreeEvent(
                  idAppointmment: medicalAppointmentList[index].id,
                ),
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MedicalAppointmentPage()));
              print(
                medicalAppointmentList[index]
                    .statusMedicalAppointment
                    .toString(),
              );
            },
            child: Text(
              medicalAppointmentList[index].id.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    Patient patient,
    List<MedicalAppointment> medicalAppointmentList,
    int totalRows,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.grey[300],
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                title: Text(
                  patient.registration,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
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
                            '/overlayPatientDetails', (route) => false);
                      },
                    ),
                  ),
                ],
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
                    padding: EdgeInsets.only(bottom: 10, left: 2),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditPatient()),
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
                          'Nome: ${patient.name}',
                          style: TextStyle(
                            fontSize: 20,
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
                child: _infiniteScroll(
                  context,
                  patient,
                  medicalAppointmentList,
                  totalRows,
                ),
              ),
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
                        builder: (context) => DiseaseHomePage(
                          patient: patient,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: BlocBuilder<PatientBloc, PatientState>(
            cubit: BlocProvider.of<PatientBloc>(context),
            builder: (context, state) {
              if (state is LoadingPatientState) {
                return _buildBody(context, state.patient, null, null);
              } else if (state is ListedAppointmentState) {
                return _buildBody(
                  context,
                  state.patient,
                  state.medicalAppointment,
                  state.totalRows,
                );
              } else if (state is SearchedPatientState) {
                return _buildBody(
                  context,
                  state.patient,
                  state.medicalAppointmentList,
                  state.totalRows,
                );
              } else {
                return Container(
                  child: Center(
                    child: Text('Erro'),
                  ),
                );
              }
            }),
      )
    ]);
  }
}

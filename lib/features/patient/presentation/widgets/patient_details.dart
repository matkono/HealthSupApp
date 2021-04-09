import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:healthsup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:healthsup/features/disease/presentation/pages/disease.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/presentation/bloc/registration_bloc.dart'
    as registration_bloc;
import 'package:healthsup/features/registration/presentation/pages/new_patient.dart';

class PatientDetails extends StatefulWidget {
  final RegisterPatientEntity patientEntity;
  const PatientDetails({
    Key key,
    this.patientEntity,
  }) : super(key: key);
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  int updateType = 0;
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
    List<MedicalAppointment> medicalAppointmentList,
    int totalRows,
  ) {
    if (medicalAppointmentList == null) {
      return Center(
        child: Text(''),
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
    int id,
    String name,
    String registration,
    List<MedicalAppointment> medicalAppointmentList,
    String cep,
    String neighborhood,
    String city,
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
                  registration,
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
                      BlocProvider.of<registration_bloc.RegistrationBloc>(
                              context)
                          .add(
                        registration_bloc.EditPatientEvent(
                          patientEntity: new RegisterPatientEntity(
                            id: id,
                            name: name,
                            registration: registration,
                            address: new CepInfo(
                                cep: cep,
                                neighborhood: neighborhood,
                                city: city),
                          ),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPatient(
                                  patientID: id,
                                  type: updateType,
                                )),
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
                          'Nome: $name',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 5),
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Text(
                          'Bairro: $neighborhood',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 5),
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Text(
                          'Cidade: $city',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 20,
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
                          patient: Patient(
                            id: id,
                            name: name,
                            registration: registration,
                          ),
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
                return CircularProgressIndicator();
              } else if (state is ListedAppointmentState) {
                return _buildBody(
                  context,
                  state.patient.id,
                  state.patient.name,
                  state.patient.registration,
                  state.medicalAppointment,
                  state.patient.address.cep,
                  state.patient.address.neighborhood,
                  state.patient.address.city,
                  state.totalRows,
                );
              } else if (state is SearchedPatientState) {
                return _buildBody(
                  context,
                  state.patient.id,
                  state.patient.name,
                  state.patient.registration,
                  state.medicalAppointmentList,
                  state.patient.address.cep,
                  state.patient.address.neighborhood,
                  state.patient.address.city,
                  state.totalRows,
                );
              } else if (state is PatientLoaded) {
                return _buildBody(
                  context,
                  state.patient.id,
                  state.patient.name,
                  state.patient.registration,
                  state.medicalAppointmentList,
                  state.patient.address.cep,
                  state.patient.address.neighborhood,
                  state.patient.address.city,
                  state.totalRows,
                );
              } else {
                return _buildBody(
                    context,
                    widget.patientEntity.id,
                    widget.patientEntity.name,
                    widget.patientEntity.registration,
                    null,
                    widget.patientEntity.address.cep,
                    widget.patientEntity.address.neighborhood,
                    widget.patientEntity.address.city,
                    null);
              }
            }),
      )
    ]);
  }
}

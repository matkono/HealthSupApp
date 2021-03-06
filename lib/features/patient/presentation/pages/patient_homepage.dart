import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/disease/presentation/widgets/diseasesList_homepage.dart';
import 'package:healthsup/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:healthsup/features/patient/presentation/widgets/patient_details.dart';
import 'package:healthsup/features/patient/presentation/widgets/patient_homepage_widget.dart';
import 'package:healthsup/features/settings/presentation/pages/settings.dart';
import 'package:flutter/material.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PatientHomePageWidget(),
    DiseasesListHomePage(),
    Settings()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: BlocListener<PatientBloc, PatientState>(
          listener: (BuildContext context, state) {
            if (state is ErrorSearchedPatientState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text(state.message),
                    content: Text('Insira um código válido!'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            }
            if (state is LoadingPatientState) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SearchedPatientState) {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientDetails(),
                  ),
                );
              });
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              body: Container(
                child: _children[_currentIndex],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: _onTabTapped,
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.blue,
                backgroundColor: Colors.grey[300],
                iconSize: 40,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_hospital,
                    ),
                    title: Text('Pacientes'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.folder,
                    ),
                    title: Text('Doenças'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    title: Text('Configurações'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

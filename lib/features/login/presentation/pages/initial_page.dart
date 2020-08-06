import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  static const routeName = 'INITIAL_PAGE';
  final Doctor doctor;
  final String title;

  InitialPage({Key key, this.doctor, this.title}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Loged in"),
      ),
      body: Center(
        child: Text("Here we have the initial page"),
      ),
    );
  }
}
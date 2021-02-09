import 'package:healthsup/features/disease/presentation/widgets/disease_homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiseaseHomePage extends StatefulWidget {
  @override
  _DiseaseHomePageState createState() => _DiseaseHomePageState();
}

class _DiseaseHomePageState extends State<DiseaseHomePage> {
  var searchPatient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DiseaseHomePageWidget(),
    );
  }
}

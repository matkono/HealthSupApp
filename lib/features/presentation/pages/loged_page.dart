import 'package:flutter/material.dart';
import 'package:mobilecache/features/domain/entities/doctor.dart';

class LogedPage extends StatefulWidget {
  static const routeName = 'HOME_PAGE';
  final Doctor doctor;
  final String title;

  LogedPage({Key key, this.doctor, this.title}) : super(key: key);

  @override
  _LogedPageState createState() => _LogedPageState();
}

class _LogedPageState extends State<LogedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Loged in"),
      ),
      body: Center(
        child: Text("${widget.doctor.email}"),
      ),
    );
  }
}
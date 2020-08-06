import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:HealthSup/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogedPage extends StatefulWidget {
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
      body: SingleChildScrollView(
        child: BlocBuilder<LoginBloc, LoginState>(
          cubit: BlocProvider.of<LoginBloc>(context),
          builder: (BuildContext context, LoginState state) {
            return Column(
              children: <Widget>[
                if (state is LoginSuccessState)
                  Container(
                    margin: EdgeInsets.only(top: 362.5),
                    alignment: Alignment.center,
                    child: FlatButton(
                      color: Colors.blue[300],
                      child: Text('Nova Consulta'),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ),
                if (state is LoginInitial)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: Container(
                      child: Center(
                        child: Text(''),
                      ),
                      alignment: Alignment.topCenter,
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width / 1,
                      color: Colors.grey,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:HealthSup/features/settings/presentation/widgets/about.dart';
import 'package:HealthSup/features/settings/presentation/widgets/account.dart';
import 'package:HealthSup/features/settings/presentation/widgets/report_problem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String valueList = 'Um';
  List<String> listTest = ['Um', 'Dois', 'Tres', 'Quatro', 'Cinco'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Column(
          children: [
            AppBar(
              title: Text(
                'Configurações',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              backgroundColor: Colors.grey[300],
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
                    child: RaisedButton(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_pin,
                            size: 60,
                            color: Colors.blue[700],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              'Conta',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 25,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountDetails(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
                    child: RaisedButton(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            size: 60,
                            color: Colors.blue[700],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              'Sobre',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 25,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppDetails(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
                    child: RaisedButton(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.help,
                            size: 60,
                            color: Colors.blue[700],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              'Relatar problema',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 25,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportProblem(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
                    child: RaisedButton(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            size: 60,
                            color: Colors.blue[700],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              'Desconectar',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 25,
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}

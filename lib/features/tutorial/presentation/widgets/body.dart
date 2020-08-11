import 'package:HealthSup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:HealthSup/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class BodyPage extends StatelessWidget {
  final List<Widget> widgetList;

  const BodyPage({
    Key key,
    @required this.widgetList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          widgetList[0],
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 15,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'Próximo',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                widgetList.removeAt(0);
                if (widgetList.isNotEmpty) {
                  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BodyPage(widgetList: widgetList)));
                } else if (widgetList.isEmpty) {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

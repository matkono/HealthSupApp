import 'package:HealthSup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:HealthSup/features/tutorial/presentation/widgets/body.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  List<Widget> widgetView = [];
  int widgetKey = 0;

  Widget bodyWidget(String image, String title, String subTitle) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.20,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Image.asset(
              image,
              width: 450,
              height: 400,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              alignment: Alignment.center,
              child: Text(
                title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(fontSize: 20, color: Colors.blue[500]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addBodyWidget() {

    widgetView.add(bodyWidget(
        'assets/images/picture2.png',
        'Pra quem é o aplicativo?',
        'Lorem ipsum dolor sit amet, consectetur'
            'adipiscing elit. Suspendisse nonneque at'
            'sapien placerat aliquam eget at turpis.'
            'Sed sapien ódio.'));

    widgetView.add(bodyWidget(
        'assets/images/picture3.png',
        'Gerencie seus atendimentos',
        'Lorem ipsum dolor sit amet, consectetur'
            'adipiscing elit. Suspendisse nonneque at'
            'sapien placerat aliquam eget at turpis.'
            'Sed sapien ódio.'));

    widgetView.add(bodyWidget(
        'assets/images/picture4.png',
        'Como criar um cadastro no HealthSup?',
        'Lorem ipsum dolor sit amet, consectetur'
            'adipiscing elit. Suspendisse nonneque at'
            'sapien placerat aliquam eget at turpis.'
            'Sed sapien ódio.'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
        if (widgetKey.toString() == '0')
          bodyWidget(
          'assets/images/picture1.png',
          'O que é o HealthSup?',
          'Lorem ipsum dolor sit amet, consectetur'
              'adipiscing elit. Suspendisse nonneque at'
              'sapien placerat aliquam eget at turpis.'
              'Sed sapien ódio.'),
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
                  if (widgetKey == 0) {
                    addBodyWidget();
                    print(widgetView);
                    widgetKey++;
                  } else if (widgetView.isEmpty && widgetKey != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalAppointment()));
                  }
                  if (widgetView.isNotEmpty) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BodyPage(widgetList: widgetView)));
                  }
              },
            ),
          ),
        ],
      ),
    );
  }
}
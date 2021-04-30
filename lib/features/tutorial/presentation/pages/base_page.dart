import 'package:healthsup/features/decision_tree/presentation/pages/medical_appointment.dart';
import 'package:healthsup/features/tutorial/presentation/widgets/body.dart';
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
        height: MediaQuery.of(context).size.height / 1.15,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Decoration.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.asset(
              image,
              width: MediaQuery.of(context).size.height / 2,
              height: MediaQuery.of(context).size.height / 2,
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
        'assets/images/Illustration2.png',
        'Pra quem é o aplicativo?',
        'É destinado aos médicos, independente da sua especialização.'));

    widgetView.add(bodyWidget(
        'assets/images/Illustration3.png',
        'Obtenha suporte nas suas consultas',
        'O fluxo de decisão foi elaborado por profissionais especializados na área de saúde do Rio de Janeiro.'));

    widgetView.add(bodyWidget(
        'assets/images/Illustration4.png',
        'Como criar um cadastro no HealthSup?',
        'Somente é necessário o envio de uma selfie segurando o CRM para o nosso e-mail healthsup.oficial@gmail.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (widgetKey.toString() == '0')
              bodyWidget(
                  'assets/images/Illustration1.png',
                  'O que é o HealthSup?',
                  'É um aplicativo universitário desenvolvido para auxiliar a tomada de decisões na área da medicina, compartilhar conhecimento e armazenar dados para identificar polos de doenças no Brasil.'),
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
                  if (widgetView.isEmpty) {
                    addBodyWidget();
                    widgetKey++;
                  } else if (widgetView.isEmpty && widgetKey != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalAppointmentPage()));
                  }
                  if (widgetView.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BodyPage(
                                  widgetList: widgetView,
                                  index: 0,
                                )));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

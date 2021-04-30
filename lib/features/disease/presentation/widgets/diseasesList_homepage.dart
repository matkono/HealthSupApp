import 'package:flutter/material.dart';
import 'package:healthsup/features/disease/presentation/widgets/cmpp_layout.dart';

class DiseasesListHomePage extends StatefulWidget {
  const DiseasesListHomePage({
    Key key,
  }) : super(key: key);

  @override
  _DiseasesListHomePageState createState() => _DiseasesListHomePageState();
}

class _DiseasesListHomePageState extends State<DiseasesListHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'Doenças',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.grey[300],
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: AssetImage('assets/images/HealthSup-logo-sem-nome.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Container(
                alignment: Alignment.topCenter,
                margin:
                    EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                )),
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  color: Colors.blue[300],
                  child: FlatButton(
                    child: Text(
                      'Cardiomiopatia Periparto',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardiomppLayout(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

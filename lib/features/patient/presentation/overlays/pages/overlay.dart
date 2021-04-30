import 'package:healthsup/features/patient/presentation/overlays/widgets/overlayCircle_homepage.dart';
import 'package:healthsup/features/patient/presentation/overlays/widgets/overlayRect_homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayHomePage extends StatefulWidget {
  @override
  _OverlayHomePageState createState() => _OverlayHomePageState();
}

class _OverlayHomePageState extends State<OverlayHomePage> {
  List<Widget> hintList = [
    OverlayTestCircle(
      width: 28,
      height: 0,
      radius: 23,
      textHint: 'Você pode adicionar pacientes aqui',
      iconHint: Icon(Icons.arrow_forward),
    ),
    OverlayTestRect(
      width: 215,
      height: 29,
      radius: 25,
      heightHint: 640,
      textHint: 'Você pode buscar pacientes aqui',
      iconHint: Icon(Icons.arrow_downward),
    ),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            child: hintList[index],
            onTap: () {
              setState(() {
                if (index == (hintList.length - 1)) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                } else {
                  index++;
                }
              });
            },
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  Stack(children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        color: Colors.transparent,
                        child: Text(
                          "${index + 1}/${hintList.length}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: FlatButton(
                      child: Text(
                        'Pular',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

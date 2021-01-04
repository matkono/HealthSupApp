import 'package:healthsup/features/patient/presentation/overlays/widgets/overlayCircle_patient_details.dart';
import 'package:healthsup/features/patient/presentation/overlays/widgets/overlayRect_patient_details.dart';
import 'package:healthsup/features/patient/presentation/overlays/widgets/overlayRect_patient_details_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayPatientDetails extends StatefulWidget {
  @override
  _OverlayPatientDetailsState createState() => _OverlayPatientDetailsState();
}

class _OverlayPatientDetailsState extends State<OverlayPatientDetails> {
  List<Widget> hintList = [
    OverlayCirclePatientDetails(
      width: 145,
      height: 0,
      radius: 23,
      textHint: 'Edite dados do paciente aqui',
      iconHint: Icon(Icons.arrow_forward),
    ),
    OverlayRectPatientDetails(
      width: 100,
      height: 29,
      radius: 20,
      heightHint: 550,
      textHint: 'Continue uma consulta aqui',
      iconHint: Icon(Icons.arrow_forward),
    ),
    OverlayRectPatientDetailsNew(
      width: 205,
      height: 25,
      radius: 50,
      heightHint: 550,
      textHint: 'Inicie uma nova consulta aqui',
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
                      context, '/patientDetails', (route) => false);
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
                            context, '/patientDetails', (route) => false);
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

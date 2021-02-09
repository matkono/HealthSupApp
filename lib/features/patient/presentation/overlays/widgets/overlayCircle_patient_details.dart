import 'package:healthsup/core/clipper/circle_clipper.dart';
import 'package:healthsup/features/patient/presentation/widgets/patient_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayCirclePatientDetails extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  final String textHint;
  final Icon iconHint;

  const OverlayCirclePatientDetails({
    Key key,
    @required this.width,
    @required this.height,
    @required this.radius,
    @required this.textHint,
    @required this.iconHint,
  }) : super(key: key);

  @override
  _OverlayCirclePatientDetailsState createState() =>
      _OverlayCirclePatientDetailsState();
}

class _OverlayCirclePatientDetailsState
    extends State<OverlayCirclePatientDetails> {
  var searchPatient = TextEditingController();

  Stack _clipPathOverlay() {
    if (1 == 1) {
      return Stack(children: <Widget>[
        _getContent(),
        Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 14,
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 14,
                    color: Colors.black38,
                    child: Stack(children: [
                      _getHint(),
                    ]),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 14,
                      child: _getClipPathOverlay(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ]);
    } else {
      return Stack(children: <Widget>[_getContent()]);
    }
  }

  Widget _getContent() {
    return PatientDetails();
  }

  ClipPath _getClipPathOverlay() {
    return ClipPath(
      clipper: InvertedClipperCircle(
        widthClipper: widget.width,
        heightClipper: widget.height,
        radiusClipper: widget.radius,
      ),
      child: Container(
        color: Colors.black38,
      ),
    );
  }

  Positioned _getHint() {
    return Positioned(
      child: Container(
        margin: EdgeInsets.only(left: 15),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Text(
              widget.textHint,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: widget.iconHint,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _clipPathOverlay(),
    );
  }
}

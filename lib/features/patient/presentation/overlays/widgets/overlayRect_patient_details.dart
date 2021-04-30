import 'package:healthsup/core/clipper/rect_clipper.dart';
import 'package:healthsup/features/patient/presentation/widgets/patient_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayRectPatientDetails extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  final int heightHint;
  final String textHint;
  final Icon iconHint;

  const OverlayRectPatientDetails({
    Key key,
    @required this.width,
    @required this.height,
    @required this.radius,
    @required this.heightHint,
    @required this.textHint,
    @required this.iconHint,
  }) : super(key: key);

  @override
  _OverlayRectPatientDetailsState createState() =>
      _OverlayRectPatientDetailsState();
}

class _OverlayRectPatientDetailsState extends State<OverlayRectPatientDetails> {
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
              color: Colors.black38,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 7,
              color: Colors.black38,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      color: Colors.black38,
                      height: MediaQuery.of(context).size.height / 14,
                      width: MediaQuery.of(context).size.width / 1,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          _getHint(),
                        ],
                      ),
                    ),
                    Container(
                      child: _getClipPathOverlay(),
                    ),
                  ],
                ),
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
      clipper: InvertedClipperRect(
        widthBox: 640,
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
      bottom: 15,
      child: Container(
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

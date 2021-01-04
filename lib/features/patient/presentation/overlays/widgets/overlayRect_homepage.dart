import 'package:healthsup/core/clipper/rect_clipper.dart';
import 'package:healthsup/features/patient/presentation/pages/patient_homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayTestRect extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  final int heightHint;
  final String textHint;
  final Icon iconHint;

  const OverlayTestRect({
    Key key,
    @required this.width,
    @required this.height,
    @required this.radius,
    @required this.heightHint,
    @required this.textHint,
    @required this.iconHint,
  }) : super(key: key);

  @override
  _OverlayTestRectState createState() => _OverlayTestRectState();
}

class _OverlayTestRectState extends State<OverlayTestRect> {
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
              height: MediaQuery.of(context).size.height / 14,
              color: Colors.black38,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              color: Colors.black38,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              color: Colors.black38,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              color: Colors.black38,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 13.5,
              color: Colors.transparent,
              child: _getClipPathOverlay(),
            ),
            Expanded(
              child: Container(
                color: Colors.black38,
              ),
            ),
          ],
        ),
        _getHint(),
      ]);
    } else {
      return Stack(children: <Widget>[_getContent()]);
    }
  }

  Widget _getContent() {
    return PatientHomePage();
  }

  ClipPath _getClipPathOverlay() {
    return ClipPath(
      clipper: InvertedClipperRect(
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
      bottom: MediaQuery.of(context).size.height - widget.heightHint,
      right: 80,
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

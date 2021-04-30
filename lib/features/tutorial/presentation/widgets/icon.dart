import 'package:flutter/material.dart';

class LoginIcon extends StatelessWidget {
  const LoginIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(150),
        topLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      ),
    );
  }
}

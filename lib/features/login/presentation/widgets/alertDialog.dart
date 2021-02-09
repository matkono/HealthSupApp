import 'package:healthsup/features/login/presentation/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecoveryAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoAlertDialog(
        content: Text(
          'Nova senha enviada pelo e-mail!',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

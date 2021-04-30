import 'package:healthsup/features/settings/presentation/widgets/alter_password.dart';
import 'package:flutter/material.dart';

class AccountDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.grey[300],
            title: Text(
              'Conta',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'DADOS CADASTRAIS',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 5),
                  margin: EdgeInsets.only(bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nome: Mateus Teixeira',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 5),
                  margin: EdgeInsets.only(bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'E-mail: mateusft@gmail.com',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 5),
                  margin: EdgeInsets.only(bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CRM: 123456789',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Telefone: (21) 1234-5678',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: MediaQuery.of(context).size.height / 14,
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              color: Colors.blue[600],
              child: Text(
                'Alterar senha',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlterPassword(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

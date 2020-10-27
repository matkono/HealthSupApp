import 'package:flutter/material.dart';

class AppDetails extends StatelessWidget {
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
              'Sobre',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          Container(
            child: Text(
              'Versão: 1.0.0',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 30,
                    bottom: 10,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'DESENVOLVIDO POR',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 45,
                    bottom: 10,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Leandro Shibahara',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 45,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mateus Kono',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

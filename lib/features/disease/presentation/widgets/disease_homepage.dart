import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiseaseHomePageWidget extends StatefulWidget {
  @override
  _DiseaseHomePageWidgetState createState() => _DiseaseHomePageWidgetState();
}

class _DiseaseHomePageWidgetState extends State<DiseaseHomePageWidget> {
  var searchPatient = TextEditingController();
  List<String> test = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doenças',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: test.length,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height / 10,
                child: RaisedButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 50,
                        color: Colors.blue[600],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25),
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Text(
                          'Nome da Doença',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {},
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

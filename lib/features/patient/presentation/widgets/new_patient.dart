import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPatient extends StatefulWidget {
  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  String valueState = 'Rio de Janeiro';
  String valueCity = 'Niterói';
  List<String> listState = [
    'Rio de Janeiro',
    'São Paulo',
    'Santa Catarina',
    'Acre',
    'Minas Generales'
  ];
  List<String> listCity = [
    'Niterói',
    'Cachoeiras de Macacu',
    'Brasília',
    'Itaboraí',
    'Angra dos Reis'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.grey[300],
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                title: Text(
                  'Cadastrar paciente',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 32),
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'NOVO PACIENTE',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 32),
                      height: MediaQuery.of(context).size.height / 20,
                      child: Text(
                        'Nome',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 15),
                      width: MediaQuery.of(context).size.width / 1.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                            )
                          ]),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 32),
                      height: MediaQuery.of(context).size.height / 20,
                      child: Text(
                        'Matrícula',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 15),
                      width: MediaQuery.of(context).size.width / 1.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                            )
                          ]),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 32, top: 10),
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'ENDEREÇO',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 32),
                      height: MediaQuery.of(context).size.height / 25,
                      child: Text(
                        'Estado',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: DropdownButton<String>(
                        value: valueState,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        onChanged: (String newValue) {
                          setState(() {
                            valueState = newValue;
                          });
                        },
                        underline: Container(
                          height: 0.5,
                          color: Colors.black,
                        ),
                        items: listState
                            .map<DropdownMenuItem<String>>((String valor) {
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 32),
                      height: MediaQuery.of(context).size.height / 25,
                      child: Text(
                        'Cidade',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: DropdownButton<String>(
                        value: valueCity,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        onChanged: (String newValue) {
                          setState(() {
                            valueCity = newValue;
                          });
                        },
                        underline: Container(
                          height: 0.5,
                          color: Colors.black,
                        ),
                        items: listCity
                            .map<DropdownMenuItem<String>>((String valor) {
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 32),
                      height: MediaQuery.of(context).size.height / 20,
                      child: Text(
                        'Rua',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 15),
                      width: MediaQuery.of(context).size.width / 1.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                            )
                          ]),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 32),
                      height: MediaQuery.of(context).size.height / 20,
                      child: Text(
                        'Bairro',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 15),
                      width: MediaQuery.of(context).size.width / 1.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                            )
                          ]),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: RaisedButton(
                  color: Colors.blue[600],
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      print(valueState);
                      print(valueCity);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Container(),
      ]),
    );
  }
}

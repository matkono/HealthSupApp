import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/patient/domain/entities/cep_info.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:healthsup/features/patient/presentation/bloc/patient_bloc.dart';

class PatientForm extends StatefulWidget {
  final Patient patient;

  const PatientForm({
    Key key,
    this.patient,
  }) : super(key: key);

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = Map();
  TextEditingController _nameController;
  TextEditingController _logradouroController;
  TextEditingController _cidadeController;
  TextEditingController _cepController;
  TextEditingController _bairroController;
  TextEditingController _matriculaController;

  @override
  void initState() {
    if (widget.patient != null) {
      _formData['NOME'] = widget.patient?.name;
      _formData['LOGRADOURO'] = widget.patient.addressInfo?.logradouro;
      _formData['CIDADE'] = widget.patient.addressInfo?.localidade;
      _formData['CEP'] = widget.patient.addressInfo?.cep;
      _formData['BAIRRO'] = widget.patient.addressInfo?.bairro;
      _formData['MATRICULA'] = widget.patient?.registration;
    }
    _nameController = TextEditingController(text: _formData['NOME']);
    _logradouroController =
        TextEditingController(text: _formData['LOGRADOURO']);
    _cidadeController = TextEditingController(text: _formData['CIDADE']);
    _cepController = TextEditingController(text: _formData['CEP']);
    _bairroController = TextEditingController(text: _formData['BAIRRO']);
    _matriculaController = TextEditingController(text: _formData['MATRICULA']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                    '* Nome',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Campo obrigatório!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _formData['NOME'] = value;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 32),
                  height: MediaQuery.of(context).size.height / 20,
                  child: Text(
                    '* Matrícula',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _matriculaController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Campo obrigatório!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _formData['MATRICULA'] = value;
                      });
                    },
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
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 32),
                  height: MediaQuery.of(context).size.height / 20,
                  child: Text(
                    '* CEP',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    maxLength: 9,
                    controller: _cepController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.black54, style: BorderStyle.solid),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Campo obrigatório!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _formData['CEP'] = value;
                        String cep = _formData['CEP'];
                        cep = cep?.replaceAll('-', '')?.replaceAll('.', '');
                        if (cep.length == 8) {
                          if (cep == null ||
                              cep.isEmpty ||
                              int.tryParse(cep) == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text("CEP inválido!"),
                                  content: Text('Insira um CEP válido!'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            BlocProvider.of<PatientBloc>(context).add(
                              GetCepInfoEvent(
                                patient: Patient(
                                  name: _formData['NOME'],
                                  registration: _formData['MATRICULA'],
                                  addressInfo: CepInfo(
                                    logradouro: _formData['LOGRADOURO'],
                                    localidade: _formData['CIDADE'],
                                    cep: _formData['CEP'],
                                    bairro: _formData['BAIRRO'],
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 32),
                  height: MediaQuery.of(context).size.height / 20,
                  child: Text(
                    'Cidade',
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
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                        )
                      ]),
                  child: TextFormField(
                    enabled: false,
                    controller: _cidadeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _formData['CIDADE'] = value;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 32),
                  height: MediaQuery.of(context).size.height / 20,
                  child: Text(
                    'Logradouro',
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
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                        )
                      ]),
                  child: TextFormField(
                    enabled: false,
                    controller: _logradouroController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _formData['LOGRADOURO'] = value;
                      });
                    },
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
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                        )
                      ]),
                  child: TextFormField(
                    enabled: false,
                    controller: _bairroController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _formData['BAIRRO'] = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 14,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
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
                if (!_formKey.currentState.validate()) {
                  return;
                }
                print(_formData['NAME']);
              },
            ),
          ),
        ],
      ),
    );
  }
}

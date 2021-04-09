import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:healthsup/features/registration/presentation/bloc/registration_bloc.dart';

class UpdatePatientForm extends StatefulWidget {
  final RegisterPatientEntity registerPatient;

  const UpdatePatientForm({
    Key key,
    this.registerPatient,
  }) : super(key: key);

  @override
  _UpdatePatientFormState createState() => _UpdatePatientFormState();
}

class _UpdatePatientFormState extends State<UpdatePatientForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = Map();
  TextEditingController _cidadeController;
  TextEditingController _cepController;
  TextEditingController _bairroController;

  @override
  void initState() {
    if (widget.registerPatient != null) {
      _formData['CEP'] = widget.registerPatient.address?.cep;
      _formData['BAIRRO'] = widget.registerPatient.address?.neighborhood;
      _formData['CIDADE'] = widget.registerPatient.address?.city;
    } else {
      _formData['CEP'] = null;
      _formData['BAIRRO'] = null;
      _formData['CIDADE'] = null;
    }
    _cepController = TextEditingController(text: _formData['CEP']);
    _bairroController = TextEditingController(text: _formData['BAIRRO']);
    _cidadeController = TextEditingController(text: _formData['CIDADE']);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.registerPatient != null) {
      _formData['CEP'] = widget.registerPatient.address?.cep;
      _formData['BAIRRO'] = widget.registerPatient.address?.neighborhood;
      _formData['CIDADE'] = widget.registerPatient.address?.city;
    } else {
      _formData['CEP'] = '';
      _formData['BAIRRO'] = '';
      _formData['CIDADE'] = '';
    }
    _cepController = TextEditingController(text: _formData['CEP']);
    _bairroController = TextEditingController(text: _formData['BAIRRO']);
    _cidadeController = TextEditingController(text: _formData['CIDADE']);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.grey[300],
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                'Editar Paciente',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 32),
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EDITAR PACIENTE',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
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
                              BlocProvider.of<RegistrationBloc>(context).add(
                                GetCepUpdateEvent(
                                  registerPatient: RegisterPatientEntity(
                                    name: null,
                                    registration: null,
                                    address: CepInfo(
                                      cep: _formData['CEP'],
                                      neighborhood: _formData['BAIRRO'],
                                      city: _formData['CIDADE'],
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
              margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
              child: RaisedButton(
                color: Colors.blue[600],
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  BlocProvider.of<RegistrationBloc>(context).add(
                    UpdatePatientEvent(
                      patientID: widget.registerPatient.id,
                      address: CepInfo(
                        cep: _formData['CEP']?.replaceAll('-', ''),
                        neighborhood: _formData['BAIRRO'],
                        city: _formData['CIDADE'],
                      ),
                    ),
                  );
                  print(_formData['NOME']);
                  print(_formData['MATRICULA']);
                  print(_formData['BAIRRO']);
                  print(_formData['CEP']?.replaceAll('-', ''));
                  print(_formData['CIDADE']);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

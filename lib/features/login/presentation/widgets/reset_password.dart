import 'package:healthsup/features/login/presentation/bloc/login_bloc.dart';
import 'package:healthsup/features/login/presentation/widgets/alertDialog.dart';
import 'package:healthsup/features/tutorial/presentation/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading;

  @override
  void initState() {
    super.initState();
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (BuildContext context, state) {},
          child: BlocBuilder<LoginBloc, LoginState>(
            cubit: BlocProvider.of<LoginBloc>(context),
            builder: (BuildContext context, LoginState state) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Base.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      LoginIcon(),
                      Column(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Stack(alignment: Alignment.center, children: <
                                      Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      padding: EdgeInsets.only(
                                        left: 16.0,
                                        right: 16.0,
                                        bottom: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 25),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.3,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.contains('@'))
                                              return null;

                                            return 'Email inválido!';
                                          },
                                          controller: emailController,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                          decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                fontSize: 15,
                                              ),
                                              border: InputBorder.none,
                                              icon: Icon(
                                                Icons.email,
                                                color: Colors.grey,
                                              ),
                                              labelText: 'Email'),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  padding: EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    bottom: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),
                                          labelText: 'Senha atual'),
                                      obscureText: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(top: 10.0, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  padding: EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    bottom: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      controller: newPasswordController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),
                                          labelText: 'Nova senha'),
                                      obscureText: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(top: 10.0, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  padding: EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    bottom: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      controller: confirmNewPasswordController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          ),
                                          labelText: 'Confirmar nova senha'),
                                      obscureText: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: FlatButton(
                              color: Colors.blue,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Recuperar senha",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      ResetPasswordEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        newPassword: newPasswordController.text,
                                        confirmNewPassword:
                                            confirmNewPasswordController.text,
                                      ),
                                    );
                                  });
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 25.0),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              },
                              child: Text(
                                "Voltar para tela de login",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:healthsup/features/login/presentation/bloc/login_bloc.dart';
import 'package:healthsup/features/login/presentation/widgets/alertDialog.dart';
import 'package:healthsup/features/login/presentation/widgets/reset_password.dart';
import 'package:healthsup/features/tutorial/presentation/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String firstPostTitle;
  bool isLoading;

  @override
  void initState() {
    super.initState();
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (BuildContext context, state) {
            print(state);
            if (state is LoginSuccessState) {
              setState(() {
                Navigator.pushNamed(context, '/home');
              });
            } else if (state is SearchSuccessState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('Nova senha definida'),
                    content: Text('Insira um CEP válido!'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            } else if (state is SearchErrorState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text(state.props.toString()),
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
            } else if (state is UpdatePasswordSuccessState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('Senha redefinida!'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            } else if (state is UpdatePasswordErrorState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('Ocorreu um erro!'),
                    content: Text('Tente novamente!'),
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
            }
          },
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
                            padding: EdgeInsets.only(top: 30.0),
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
                                              13,
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
                                        margin: EdgeInsets.only(top: 20),
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
                            padding: EdgeInsets.only(top: 20.0, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height:
                                      MediaQuery.of(context).size.height / 13,
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
                                          labelText: 'Password'),
                                      obscureText: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (state == LoginStartState())
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: CircularProgressIndicator(),
                            )
                          else if (state is LoginEmptyErrorState)
                            Container(
                              child: Text(
                                state.message1,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              margin: EdgeInsets.only(top: 15, bottom: 15),
                            )
                          else if (state is LoginErrorState)
                            Container(
                              child: Text(
                                state.message2,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              margin: EdgeInsets.only(top: 15, bottom: 15),
                            )
                          else
                            Container(
                              child: Text(''),
                              margin: EdgeInsets.only(bottom: 30),
                            ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
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
                                        "Login",
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
                                      SignInEvent(
                                          email: emailController.text,
                                          password: passwordController.text),
                                    );
                                  });
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 40),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResetPassword()),
                                );
                              },
                              child: Text(
                                'Redefinir senha',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          )
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

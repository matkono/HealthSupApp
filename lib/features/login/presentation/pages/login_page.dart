import 'package:HealthSup/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final String errorMessage;

  LoginPage({this.errorMessage});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            if (state is LoginSuccessState) {
              setState(() {
                Navigator.pushNamed(context, '/logged');
              });
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            cubit: BlocProvider.of<LoginBloc>(context),
            builder: (BuildContext context, LoginState state) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0XFF0091EA), Color(0xFF80D8FF)]),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(150),
                            topLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person,
                              size: 90.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 50.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 50.0,
                                  padding: EdgeInsets.only(
                                    top: 4.0,
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
                                        blurRadius: 15.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'Email',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height: 50.0,
                                  padding: EdgeInsets.only(
                                    top: 4.0,
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
                                        blurRadius: 15.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.vpn_key,
                                        color: Colors.grey,
                                      ),
                                      hintText: 'Password',
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 32.0, top: 20.0, bottom: 20),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          if (state == LoginStartState())
                            CircularProgressIndicator()
                          else if (state == LoginEmptyErrorState())
                            Container(
                              child: Text(state.props.toString()),
                              margin: EdgeInsets.only(bottom: 30),
                            )
                          else if (state == LoginErrorState())
                            Container(
                              child: Text(state.props.toString()),
                              margin: EdgeInsets.only(bottom: 30),
                            )
                          else
                            Container(
                              child: Text(''),
                              margin: EdgeInsets.only(bottom: 30),
                            ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 6.0, left: 60, right: 60),
                            child: FlatButton(
                              color: Colors.lightBlue[300],
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.0,
                                    height:
                                        MediaQuery.of(context).size.height / 13,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Login",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                setState(() {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    SignInEvent(
                                        email: emailController.text,
                                        password: passwordController.text),
                                  );
                                });
                              },
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 7.5,
                            padding: EdgeInsets.only(top: 50.0),
                            child: Text(
                              "Don't have an account? Register!",
                              style: TextStyle(fontSize: 17.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobilecache/features/data/models/doctor_model.dart';
import 'package:mobilecache/features/presentation/blocs/login_bloc/bloc.dart';
import 'package:mobilecache/features/presentation/blocs/login_bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'LOGIN_PAGE';
  final String errorMessage;

  LoginPage({this.errorMessage});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var listJson = List<DoctorModel>();

  @override
  void initState() {
    super.initState();
  }

  var crmController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = BlocProvider.of<LoginBloc>(context);

    void _authenticate() {
      final signInEvent = SignInEvent(
        crm: crmController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      bloc.add(signInEvent);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                      bottomLeft: Radius.circular(200),
                      topLeft: Radius.circular(200),
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
                    Align(
                      alignment: Alignment.centerLeft / 1.5,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50.0,
                        padding: EdgeInsets.only(
                          top: 4.0,
                          left: 16.0,
                          right: 16.0,
                          bottom: 4.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15.0,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: crmController,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.security,
                              color: Colors.grey,
                            ),
                            hintText: 'CRM',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
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
                            width: MediaQuery.of(context).size.width / 1.2,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 32.0, top: 20.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 60.0),
                      child: FlatButton(
                        child: Column(
                          children: <Widget>[
                            widget.errorMessage == null
                                ? SizedBox()
                                : Text(widget.errorMessage),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue[300],
                              ),
                              width: MediaQuery.of(context).size.width / 1.32,
                              height: MediaQuery.of(context).size.height / 13,
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
                        onPressed: () {
                          _authenticate();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 25.0),
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
        ),
      ),
    );
  }
}

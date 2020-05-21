// abstract class LoginRemoteDataSource {
//   Future<String> makeLogin(LoginUserModel user);
//   Future<bool> recoverPassword(String email);
// }

// class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
//   final http.Client client;
//   final Settings settings;

//   LoginRemoteDataSourceImpl({@required this.client, @required this.settings});
//   @override
//   Future<String> makeLogin(LoginUserModel user) async {
//     http.Response response;
//     try {
//       response = await client.post(
//         settings.getUrl("rest-auth/login/"),
//         headers: settings.getHeaders(),
//         body: json.encode(user.toJson()),
//       );
//     } catch (e, stacktrace) {
//       print(e.toString());
//       print((response == null) ? "Response is null" : response.body);
//       di.sl<SentryClient>().captureException(
//         exception: e.toString(),
//         stackTrace: stacktrace.toString(),
//       );
//       throw ServerException();
//     }
//     if (response.statusCode == 200) {
//       return json.decode(utf8.decode(response.bodyBytes))["key"];
//     } else if (response.statusCode == 201) {
//       throw EmailNotVerifiedException(email: user.user);
//     } else if (response.statusCode == 400) {
//       throw ExceptionConverter.convertMapToException(
//           json.decode(utf8.decode(response.bodyBytes)), user.user);
//     } else {
//       throw ServerException();
//     }
//   }

//   Future<bool> recoverPassword(String email) async {
//     http.Response response;
//     try {
//       response = await client.post(
//         settings.getUrl("rest-auth/password/reset/"),
//         headers: settings.getHeaders(),
//         body: json.encode({'email': email}),
//       );
//     } catch (e, stacktrace) {
//       print(e.toString());
//       print((response == null) ? "Response is null" : response.body);
//       di.sl<SentryClient>().captureException(
//         exception: e.toString(),
//         stackTrace: stacktrace.toString(),
//       );
//       throw ServerException();
//     }
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       throw ServerException();
//     }
//   }
// }

// ----------------------------------


// class Settings {
//   static const String _DEBUG_MODE = "debug";
//   static const String _RELEASE_MODE = "release";
//   static final String _baseUrlRelease =
//       "Sua url de release";
//   static final String _baseUrlDevelop = "http://10.0.2.2:8000/";

//   static final String _mode = _RELEASE_MODE;

//   final SharedPreferences sharedPreferences;

//   Settings({@required this.sharedPreferences});

//   String getUrl(String params) {
//     String baseUrl = (_mode == _DEBUG_MODE) ? _baseUrlDevelop : _baseUrlRelease;

//     if (params == null) return null;
//     return "$baseUrl$params";
//   }

//   Map<String, String> getHeaders({bool withToken = false, bool isJson = true}) {
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
      
//     };

//     if (withToken && sharedPreferences.containsKey("CACHED_USER_TOKEN")) {
//       headers.addAll({
//         'Authorization': "token ${sharedPreferences.get("CACHED_USER_TOKEN")}"
//       });
//     }

//     return headers;
//   }

//   Future<String> getUserToken() async {
//     return sharedPreferences.get("CACHED_USER_TOKEN");
//   }
// }

// ----------------------

// if (withToken && sharedPreferences.containsKey("CACHED_USER_TOKEN")) {
//       headers.addAll({
//         'Authorization': "token ${sharedPreferences.get("CACHED_USER_TOKEN")}"
//       });
//     }

// long lastUpdate = ${sharedPreferences.get("LAST_UPDATE");
// long currentDate = DateTime.now().toMilisecondsSinceEpoc

// If (lastUpdate == null !! currenteDate - lastUpdate > 30*60*1000) {
//  sharedPreferences.putString ("CACHED_USER_TOKEN", seuMetodoDePegarToken());

// sharedPreferences.putString ("LAST_UPDATE", DateTime.now(). millisecondsSinceEpoc);
// }


// ---------------------------- COOKIES ---------------------------- //

import 'dart:io';

import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';


var cj = new CookieJar();

class Session {
  static HttpClient client = new HttpClient()
    ..badCertificateCallback = (_certificateCheck);


  static Future<String> apiGet(String url) async {
    HttpClientRequest request = await client.getUrl(Uri.parse(url));

    _setHeadersCookies(request, url);

    HttpClientResponse response = await request.close();

    _updateCookies(response, url);

    return await response.transform(utf8.decoder).join();
  }

  static Future<String> apiPost(String url, dynamic data) async {
    HttpClientRequest request = await client.postUrl(Uri.parse(url));

    _setHeadersCookies(request, url);

    request.add(utf8.encode(json.encode(data)));

    HttpClientResponse response = await request.close();

    _updateCookies(response, url);

    return await response.transform(utf8.decoder).join();
  }

  static void _setHeadersCookies(HttpClientRequest request, String url) {
    request.headers.set('content-type', 'application/json');
    request.cookies.addAll(cj.loadForRequest(Uri.parse(url)));
  }

  static void _updateCookies(HttpClientResponse response, String url) {
    cj.saveFromResponse(Uri.parse(url), response.cookies);
  }

  static bool _certificateCheck(X509Certificate cert, String host, int port) =>
      host == 'local.domain.ext';
  }










































import 'package:cardiompp/core/connection/dio_connectivity_request_retrier.dart';
import 'package:cardiompp/core/connection/retry_interceptor.dart';
import 'package:cardiompp/features/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'LOGIN_PAGE';
  final String errorMessage;

  LoginPage({this.errorMessage});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Dio dio;
  String firstPostTitle;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    firstPostTitle = 'Press the button';
    isLoading = false;

    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
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
              if (isLoading)
                CircularProgressIndicator()
              else
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
                          setState(() {
                            isLoading = true;
                          });
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
    // else AlertDialog(
    //   title: Text('No Internet connection'),
    //   content: Text('Check your internet'),
    //   elevation: 24.0,
    //   actions: [
    //     FlatButton(
    //       child: Text('Retry'),
    //       onPressed: () {
    //         print('Retry');
    //       }
    //     ),
    //     FlatButton(
    //       child: Text('Exit'),
    //       onPressed: () {
    //         SystemNavigator.pop();
    //       }
    //     ),
    //   ]);
  }
}

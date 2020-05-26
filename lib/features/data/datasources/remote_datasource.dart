import 'dart:convert';
import 'dart:io';
import 'package:cardiompp/features/data/datasources/settingsAPI.dart';
import 'package:cardiompp/features/data/models/authenticateAPI_model.dart';
import 'package:cardiompp/features/data/models/loginApp_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class DoctorRemoteDataSource {
  Future<bool> getLoginDataFromAPI(String email, String password, SharedPreferences preferences);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  var currentTime = DateTime.now().millisecondsSinceEpoch;
  final SettingsAPI settingsAPI = new SettingsAPI();

  Future<dynamic> authenticatorAPI(LoginAPIModel user) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == settingsAPI.getUrl(null);
      return isValidHost;
    });

    String urlAuth = 'authentication/';
    Map map = user.toJson();

    HttpClientRequest request = await client.postUrl(Uri.parse(settingsAPI.getUrl(urlAuth)));

    await settingsAPI.setHeaders(request);
    request.add(utf8.encode(json.encode(map)));

    HttpClientResponse response = await request.close();

    String body = await response.transform(utf8.decoder).join();
    var jsonDecoded = json.decode(body);
    
    return jsonDecoded;
  }

  @override
  Future<bool> getLoginDataFromAPI(String email, String password, preferences) async {
     var client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == settingsAPI.getUrl(null);
      return isValidHost;
    });

    String urlLogin ='Doctor/login/';

    var login = new LoginDoctorModel(
      email: email,
      password: password,
    );

    HttpClientRequest request = await client.postUrl(Uri.parse(settingsAPI.getUrl(urlLogin)));

    await settingsAPI.setHeaders(request);
    request.add(utf8.encode(json.encode(login.toJson())));

    HttpClientResponse response = await request.close();

    var body = await response.transform(utf8.decoder).join();
    var jsonLoginResponse = json.decode(body);
    print('body Errors: ' + jsonLoginResponse['errors'].toString());
    if (response.statusCode == 200) {
      print('statusCode: ' + response.statusCode.toString());
      print('body: ' + body);
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}

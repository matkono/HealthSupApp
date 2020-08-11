import 'dart:convert';
import 'dart:io';
import 'package:HealthSup/features/login/data/models/doctor_model.dart';
import 'package:HealthSup/core/error/exception.dart';
import 'package:HealthSup/features/login/data/datasources/settingsAPI.dart';
import 'package:HealthSup/features/login/data/models/authenticateAPI_model.dart';
import 'package:HealthSup/features/login/data/models/loginApp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DoctorRemoteDataSource {
  Future<DoctorModel> getLoginDataFromAPI(
      String email, String password, SharedPreferences preferences);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  var currentTime = DateTime.now().millisecondsSinceEpoch;
  final SettingsAPI settingsAPI = new SettingsAPI();

  Future<Map<dynamic, dynamic>> authenticatorAPI(
      AuthenticateApiModel user) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == settingsAPI.getUrl(null);
      return isValidHost;
    });

    // settingsAPI.CertificateHost(client);

    String urlAuth = 'authentication/';

    Map map = user.toJson();

    HttpClientRequest request =
        await client.postUrl(Uri.parse(settingsAPI.getUrl(urlAuth)));

    await settingsAPI.setHeaders(request);
    request.add(utf8.encode(json.encode(map)));

    HttpClientResponse response = await request.close();
    String body = await response.transform(utf8.decoder).join();
    Map jsonDecoded = json.decode(body);
  
    return jsonDecoded;
  }

  @override
  Future<DoctorModel> getLoginDataFromAPI(
      String email, String password, preferences) async {
    var client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == settingsAPI.getUrl(null);
      return isValidHost;
    });

    // settingsAPI.CertificateHost(client);

    var login = new LoginDoctorModel(
      email: email,
      password: password,
    );
    String urlLogin = 'Doctor/login/';

    try {
      HttpClientRequest request =
          await client.postUrl(Uri.parse(settingsAPI.getUrl(urlLogin)));

      await settingsAPI.setHeaders(request);
      request.add(utf8.encode(json.encode(login.toJson())));

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonLoginResponse = json.decode(body);
      Map jsonData = jsonLoginResponse['data'];
      
      if (jsonData == null) {
        throw ServerException(exceptionMessage: jsonLoginResponse['errors'][0]['message']);
      }

      if (response.statusCode == 200) {
        var doctor = jsonLoginResponse['data'];
        var doctorModel = new DoctorModel.fromJson(doctor);

        print('statusCode: ' + response.statusCode.toString());

        return doctorModel;
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:HealthSup/core/authentication/authentication.dart';
import 'package:HealthSup/core/authentication/model/authentication_model.dart';
import 'package:HealthSup/core/settings/settings.dart';
import 'package:HealthSup/features/login/data/models/doctor_model.dart';
import 'package:HealthSup/core/error/exception.dart';
import 'package:HealthSup/features/login/data/models/loginApp_model.dart';
import 'package:flutter/material.dart';

abstract class LoginRemoteDataSource {
  Future<DoctorModel> getLoginUser(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Settings settings;
  final AuthenticationSettings authenticationSettings;
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var authModel = new AuthenticationModel(
    agentKey: "db39648a-14f5-406f-94d8-1b43d266f1dd",
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  LoginRemoteDataSourceImpl({
    @required this.settings,
    @required this.authenticationSettings,
  });

  Future<void> authenticatorAPI(AuthenticationModel user) async {
    try {
      HttpClient client = new HttpClient();
      settings.certificateHost(client);

      bool expiredToken =
          await authenticationSettings.validateTokenTime(tokenTimeKey);

      if (expiredToken == true) {
        await authenticationSettings.resetSharedPreferences();
        String urlAuth = 'Authentication/agentAuthentication/token/';
        Map map = user.toJson();

        var url = settings.getUrl(urlAuth);
        var uriParse = Uri.parse(url);

        HttpClientRequest request =
            await client.postUrl(uriParse).timeout(Duration(seconds: 10));
        await settings.setHeaders(request);
        request.add(utf8.encode(json.encode(map)));
        HttpClientResponse response = await request.close();
        String body = await response.transform(utf8.decoder).join();
        print(body);
        Map jsonDecoded = json.decode(body);

        await authenticationSettings.setSharedPreferences(jsonDecoded);
      }
    } on TimeoutException catch (e) {
      throw e;
    } on SocketException catch (e) {
      throw e;
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<DoctorModel> getLoginUser(String email, String password) async {
    var client = new HttpClient();

    settings.certificateHost(client);

    var login = new LoginDoctorModel(
      email: email,
      password: password,
    );
    String urlLogin = 'Authentication/userAuthentication/';

    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settings.getUrl(urlLogin)))
          .timeout(Duration(seconds: 10));

      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(login.toJson())));

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonLoginResponse = json.decode(body);
      Map jsonData = jsonLoginResponse['data'];

      if (jsonData == null) {
        throw ServerException(
            exceptionMessage: jsonLoginResponse['errors'][0]['message']);
      }

      if (response.statusCode == 200) {
        var doctor = jsonLoginResponse['data'];
        var doctorModel = new DoctorModel.fromJson(doctor);

        print('statusCode: ${response.statusCode}');

        return doctorModel;
      } else {
        print('statusCode: ${response.statusCode}');
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }
}

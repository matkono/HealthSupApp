import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthsup/core/authentication/authentication.dart';
import 'package:healthsup/core/authentication/model/authentication_model.dart';
import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/settings/settings.dart';
import 'package:healthsup/features/registration/data/models/cep_info_model.dart';
import 'package:healthsup/features/registration/data/models/register_patient_model.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:via_cep/via_cep.dart';

abstract class RegisterRemoteDataSource {
  Future<RegisterPatientEntity> registerPatient(String name,
      String registration, String neighborhood, String cep, String city);
  Future<CepInfoModel> viaCep(String cep);
  Future<RegisterPatientEntity> updatePatient(int patientID, CepInfo address);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  // Parâmetros mocados
  final Settings settings;
  final AuthenticationSettings authenticationSettings;
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var authModel = new AuthenticationModel(
    agentKey: "db39648a-14f5-406f-94d8-1b43d266f1dd",
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  RegisterRemoteDataSourceImpl({
    @required this.settings,
    @required this.authenticationSettings,
  });

  Future<void> authenticatorAPI(AuthenticationModel authUser) async {
    try {
      HttpClient client = new HttpClient();
      settings.certificateHost(client);

      bool expiredToken =
          await authenticationSettings.validateTokenTime(tokenTimeKey);
      if (expiredToken == true) {
        await authenticationSettings.resetSharedPreferences();
        String urlAuth = 'Authentication/agentAuthentication/token/';
        Map map = authUser.toJson();

        String url = settings.getUrl(urlAuth);
        Uri uriParse = Uri.parse(url);

        HttpClientRequest request =
            await client.postUrl(uriParse).timeout(Duration(seconds: 10));
        await settings.setHeaders(request);
        request.add(utf8.encode(json.encode(map)));
        HttpClientResponse response = await request.close();
        String body = await response.transform(utf8.decoder).join();
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
  Future<RegisterPatientEntity> registerPatient(String name,
      String registration, String neighborhood, String cep, String city) async {
    var client = new HttpClient();
    settings.certificateHost(client);

    var address =
        new CepInfoModel(cep: cep, neighborhood: neighborhood, city: city);

    var requestBody = {
      "patient": {
        "name": name,
        "registration": registration,
        "address": address.toJson(),
      }
    };
    String url = 'Patient';
    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));
      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(requestBody)));

      HttpClientResponse response = await request.close();
      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      if (response.statusCode == 200) {
        print('statusCode: ' + response.statusCode.toString());
        return RegisterPatientModel.fromJson(jsonData);
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<CepInfoModel> viaCep(String cep) async {
    var viaCep = new via_cep();
    await viaCep.searchCEP(cep, 'json', '');

    if (viaCep.getResponse() == 200) {
      final cepInfo = CepInfoModel(
        cep: viaCep.getCEP(),
        neighborhood: viaCep.getBairro(),
        city: viaCep.getLocalidade(),
      );
      return cepInfo;
    } else {
      print('Código de Retorno: ' + viaCep.getResponse().toString());
      print('Erro: ' + viaCep.getBody());
      throw ZipCodeException();
    }
  }

  @override
  Future<RegisterPatientEntity> updatePatient(
      int patientID, CepInfo address) async {
    var client = new HttpClient();
    settings.certificateHost(client);

    var requestAddress = {
      'address': new CepInfoModel(
        cep: address.cep,
        neighborhood: address.neighborhood,
        city: address.city,
      ),
    };

    String url = 'Patient/$patientID';

    print(url);
    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .patchUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));
      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(requestAddress)));

      HttpClientResponse response = await request.close();
      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      if (response.statusCode == 200) {
        print('statusCode: ' + response.statusCode.toString());
        return RegisterPatientModel.fromJson(jsonData);
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }
}

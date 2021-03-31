import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthsup/core/authentication/authentication.dart';
import 'package:healthsup/core/authentication/model/authentication_model.dart';
import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/settings/settings.dart';
import 'package:healthsup/features/registration/data/models/cep_info_model.dart';
import 'package:healthsup/features/registration/domain/entities/register_patient_entity.dart';
import 'package:via_cep/via_cep.dart';

abstract class RegisterRemoteDataSource {
  Future<RegisterPatientEntity> registerPatient(RegisterPatientEntity patient);
  Future<CepInfoModel> viaCep(String cep);
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
  Future<RegisterPatientEntity> registerPatient(RegisterPatientEntity patient) {
    return null;
  }

  @override
  Future<CepInfoModel> viaCep(String cep) async {
    var viaCep = new via_cep();
    print(cep);
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
}

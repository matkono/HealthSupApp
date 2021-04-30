import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:healthsup/core/authentication/authentication.dart';
import 'package:healthsup/core/authentication/model/authentication_model.dart';
import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/settings/settings.dart';
import 'package:healthsup/features/decision_tree/data/models/answer_model.dart';
import 'package:healthsup/features/decision_tree/data/models/medical_appointment_model.dart';
import 'package:healthsup/features/decision_tree/data/models/node_model.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/disease/data/models/choosed_disease_model.dart';

abstract class DecisionTreeRemoteDataSource {
  Future<MedicalAppointment> startNodeMedicalAppointment(
      int patientId, int diseaseId);
  Future<NodeModel> setAnswer(AnswerModel answer);
  Future<NodeModel> getPreviousQuestion(
      int idMedicalAppointment, int idCurrentNode);
  Future<void> finishAppointment(int idAppointment, int idDecision);
  Future<NodeModel> getCurrentNode(int idAppointment);
  Future<NodeModel> confirmAction(int idAction, int idAppointment);
}

class DecisionTreeRemoteDataSourceImpl extends DecisionTreeRemoteDataSource {
  // Parâmetros mocados
  final Settings settings;
  final AuthenticationSettings authenticationSettings;
  final int userId = 0;
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var authModel = new AuthenticationModel(
    agentKey: "db39648a-14f5-406f-94d8-1b43d266f1dd",
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  DecisionTreeRemoteDataSourceImpl({
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
  Future<MedicalAppointment> startNodeMedicalAppointment(
      int patientId, int diseaseId) async {
    var client = new HttpClient();
    settings.certificateHost(client);

    ChoosedDiseaseModel choosedDisease =
        new ChoosedDiseaseModel(patientId: patientId, diseaseId: diseaseId);
    String url = 'MedicalAppointment/create';

    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(choosedDisease.toJson())));

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      if (response.statusCode == 200) {
        print('statusCode: ' + response.statusCode.toString());
        return MedicalAppointmentModel.fromJson(jsonData);
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<NodeModel> setAnswer(AnswerModel answer) async {
    var client = new HttpClient();
    settings.certificateHost(client);

    String url = 'DecisionEngine/node/question/answer/';

    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(answer.toJson())));

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      if (jsonData == null) {
        throw ServerException(
            exceptionMessage: jsonResponse['errors'][0]['message']);
      }

      if (response.statusCode == 200) {
        print('statusCode: ' + response.statusCode.toString());

        return NodeModel.fromJson(jsonData);
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<NodeModel> getPreviousQuestion(
      int idMedicalAppointment, int idCurrentNode) async {
    var client = new HttpClient();
    settings.certificateHost(client);

    Map previousQuestion = {
      'medicalAppointmentId': idMedicalAppointment,
      'currentNodeId': idCurrentNode,
    };

    String url = 'DecisionEngine/node/previous/';

    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(previousQuestion)));

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      if (jsonData == null) {
        throw ServerException(
            exceptionMessage: jsonResponse['errors'][0]['message']);
      }

      if (response.statusCode == 200) {
        print('statusCode: ' + response.statusCode.toString());

        return NodeModel.fromJson(jsonData);
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<NodeModel> getCurrentNode(int idAppointment) async {
    var client = new HttpClient();
    settings.certificateHost(client);
    print('idAppointment: $idAppointment');
    String url = 'MedicalAppointment/$idAppointment/currentNode/';

    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .getUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settings.setHeaders(request);
      await settings.setToken(request);

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      if (jsonData == null) {
        throw ServerException(
            exceptionMessage: jsonResponse['errors'][0]['message']);
      }

      if (response.statusCode == 200) {
        print('statusCode: ' + response.statusCode.toString());
        return NodeModel.fromJson(jsonData);
      } else if (response.statusCode == 400) {
        throw ServerException();
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> finishAppointment(int idAppointment, int idDecision) async {
    var client = new HttpClient();
    settings.certificateHost(client);

    Map decision = {
      'medicalAppointmentId': idAppointment,
      'decisionId': idDecision,
    };

    String url = 'DecisionEngine/node/decision/confirm/';

    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(decision)));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<NodeModel> confirmAction(int idAction, int idAppointment) async {
    var client = new HttpClient();
    settings.certificateHost(client);

    Map action = {
      'medicalAppointmentId': idAppointment,
      'actionId': idAction,
    };

    String url = 'DecisionEngine/node/action/confirm/';

    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(action)));

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      if (jsonData == null) {
        throw ServerException(
            exceptionMessage: jsonResponse['errors'][0]['message']);
      }

      if (response.statusCode == 200) {
        print('statusCode: ' + response.statusCode.toString());

        return NodeModel.fromJson(jsonData);
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }
}

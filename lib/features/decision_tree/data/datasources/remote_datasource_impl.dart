import 'dart:convert';
import 'dart:io';
import 'package:HealthSup/core/error/exception.dart';
import 'package:HealthSup/features/decision_tree/data/models/answer_model.dart';
import 'package:HealthSup/features/decision_tree/data/models/authenticateApi_model.dart';
import 'package:HealthSup/features/decision_tree/data/models/node_model.dart';
import 'package:HealthSup/features/login/data/datasources/settingsAPI.dart';
import 'package:flutter/material.dart';

abstract class DecisionTreeRemoteDataSource {
  Future<NodeModel> startNodeMedicalAppointment();
  Future<NodeModel> setAnswer(AnswerModel answer);
  Future<NodeModel> getPreviousQuestion(
      int idMedicalAppointment, int idCurrentNode);
  Future<void> finishAppointment(int idAppointment, bool finished);
  Future<NodeModel> getCurrentNode(int idAppointment);
  Future<NodeModel> confirmAction(int idAction, int idAppointment);
}

class DecisionTreeRemoteDataSourceImpl extends DecisionTreeRemoteDataSource {
  final SettingsAPI settingsAPI;
  // Parâmetros mocados
  final int appointmentId = 1;
  final int userId = 0;
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var loginAPIModel = new AuthenticateApiModel(
    agentName: 'db39648a-14f5-406f-94d8-1b43d266f1dd',
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  DecisionTreeRemoteDataSourceImpl({
    @required this.settingsAPI,
  });

  @override
  Future<NodeModel> startNodeMedicalAppointment() async {
    // TO DO
    // Iremos usar o endpoint currentNode, mas no futuro deverá ser o endpoint de criação de consulta

    return await getCurrentNode(appointmentId);
  }

  @override
  Future<NodeModel> setAnswer(AnswerModel answer) async {
    final settingsAPI = SettingsAPI();

    var client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == settingsAPI.getUrl(null);
      return isValidHost;
    });

    String url = 'DecisionEngine/node/question/answer/';

    try {
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settingsAPI.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settingsAPI.setHeaders(request);
      request.add(utf8.encode(json.encode(answer.toJson())));

      print('request: ${utf8.encode(json.encode(answer.toJson()))}');

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      print(jsonData);

      // TO DO
      // Confirmar contrato de erro

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
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == settingsAPI.getUrl(null);
      return isValidHost;
    });

    Map previousQuestion = {
      'medicalAppointmentId': idMedicalAppointment,
      'currentNodeId': idCurrentNode,
    };

    String url = 'DecisionEngine/node/previous/';

    try {
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settingsAPI.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settingsAPI.setHeaders(request);
      request.add(utf8.encode(json.encode(previousQuestion)));

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      // TO DO
      // Confirmar contrato de erro

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
    final settingsAPI = SettingsAPI();

    var client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == settingsAPI.getUrl(null);
      return isValidHost;
    });

    String url =
        'MedicalAppointment/$idAppointment/currentNode/';
    print(url);
    try {
      HttpClientRequest request = await client
          .getUrl(Uri.parse(settingsAPI.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settingsAPI.setHeaders(request);

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      print(body);
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      // TO DO
      // Confirmar contrato de erro

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
  Future<void> finishAppointment(int idAppointment, bool finished) async {
    print('Finish Appointment');
    return null;
  }

  @override
  Future<NodeModel> confirmAction(int idAction, int idAppointment) async {
    var client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == settingsAPI.getUrl(null);
      return isValidHost;
    });

    Map action = {
      'medicalAppointmentId': idAppointment,
      'actionId': idAction,
    };

    String url = 'DecisionEngine/node/action/confirm/';

    try {
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settingsAPI.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settingsAPI.setHeaders(request);
      request.add(utf8.encode(json.encode(action)));

      print(utf8.encode(json.encode(action)));

      HttpClientResponse response = await request.close();

      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      Map jsonData = jsonResponse['data'];

      // TO DO
      // Confirmar contrato de erro

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

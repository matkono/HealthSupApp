import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthsup/core/authentication/authentication.dart';
import 'package:healthsup/core/authentication/model/authentication_model.dart';
import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/settings/settings.dart';
import 'package:healthsup/features/disease/data/models/disease_model.dart';
import 'package:healthsup/features/disease/data/models/diseases_list_model.dart';
import 'package:healthsup/features/disease/data/models/pagination_model.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';

abstract class DiseaseRemoteDataSource {
  Future<DiseaseListModel> getDiseaseList(Pagination pagination);
}

class DiseaseRemoteDataSourceImpl implements DiseaseRemoteDataSource {
  // Parâmetros mocados
  final Settings settings;
  final AuthenticationSettings authenticationSettings;
  final int appointmentId = 1;
  final int userId = 0;
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var authModel = new AuthenticationModel(
    agentKey: "db39648a-14f5-406f-94d8-1b43d266f1dd",
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  DiseaseRemoteDataSourceImpl({
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
  Future<DiseaseListModel> getDiseaseList(Pagination pagination) async {
    var client = new HttpClient();
    settings.certificateHost(client);

    PaginationModel paginationModel = new PaginationModel(
      pageSize: pagination.pageSize,
      pageNumber: pagination.pageNumber,
    );

    String url = 'Disease/listPaged';
    Map page = {
      "pagination": paginationModel.toJson(),
    };

    try {
      await authenticatorAPI(authModel);
      HttpClientRequest request = await client
          .postUrl(Uri.parse(settings.getUrl(url)))
          .timeout(Duration(seconds: 10));

      await settings.setHeaders(request);
      await settings.setToken(request);
      request.add(utf8.encode(json.encode(page)));

      HttpClientResponse response = await request.close();
      String body = await response.transform(utf8.decoder).join();
      Map jsonResponse = json.decode(body);
      List jsonDataDisease = jsonResponse['data']['patients'];

      int start = (pagination.pageNumber - 1) * pagination.pageSize;
      int end = start + pagination.pageSize;

      var currentList = jsonDataDisease.sublist(
          start > (jsonDataDisease.length) ? (jsonDataDisease.length) : start,
          end > (jsonDataDisease.length) ? (jsonDataDisease.length) : end);

      var diseaseList = new DiseaseListModel(
        patients: DiseasesModel.listFromJson(currentList),
        pageNumber: pagination.pageNumber,
        pageSize: pagination.pageSize,
        totalRows: jsonDataDisease.length,
      );

      if (response.statusCode == 200) {
        print('statusCode: ' + response.statusCode.toString());

        return diseaseList;
      } else {
        print('statusCode: ' + response.statusCode.toString());
        throw ServerException();
      }
    } on Exception catch (_) {
      throw ServerException();
    }
  }
}

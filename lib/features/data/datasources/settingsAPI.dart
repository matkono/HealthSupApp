import 'dart:io';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsAPI {

  static final String hostUrlDevelop = 'https://10.0.2.2:5001/';
  var tokenCurrentTime = DateTime.now().millisecondsSinceEpoch;

  String getUrl(String params) {
    String urlDevelop = hostUrlDevelop;

    if (params == null) {
      return null;
    }
    return '$urlDevelop$params';
  }

  Future<void> setHeaders(HttpClientRequest request) async {
    var preferences = await SharedPreferences.getInstance();

    request.headers.set('Content-type', 'application/json');

    if (preferences.containsKey("tokenJWT")) {
      String tokenJWT = await getTokenSharedPreferences('tokenJWT');
      request.headers.add('Authorization', 'Bearer  $tokenJWT');
    }
  }

  Future<void> setSharedPreferences(Map<String, dynamic> bodyResponse) async {
    var preferences = await SharedPreferences.getInstance();
    var token = bodyResponse['data']['token'];

    preferences.setString('tokenJWT', token);
    preferences.setInt('tokenCurrentTime', tokenCurrentTime);
  }

  Future<String> getTokenSharedPreferences(String key) async {
    var preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(key)) {
      var getToken = preferences.getString(key);
  
      return getToken;
    }
    return null;
  }

  Future<int> getTokenTimeSharedPreferences(String key) async {
    var preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(key)) {
      int getToken = preferences.getInt(key);
  
      return getToken;
    }
    return null;
  }

  Future<bool> validateTokenTime(String key) async {
    var preferences = await SharedPreferences.getInstance();
    var timeNow = DateTime.now().millisecondsSinceEpoch;

    if (preferences.containsKey(key)) {
      var tokenTime = preferences.getInt(key);

      print('tokenTime Armazenado: $tokenTime');
      print('tokenTime Atual: $timeNow');
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1OTAwMzEwMjYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0Mzc4IiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzNzgifQ.9w5HR_NiItK1MJvZzYeiq25CXyqAY1iqd7KtzAfyrNY
      if (timeNow - tokenTime > 29*60*1000) {
        return true;
      }
      return false;
    }
    return null;
  }

  Future<void> resetSharedPreferences() async {
    var preferences = await SharedPreferences.getInstance();

    preferences.clear();
  }
}
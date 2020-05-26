import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsAPI {
  static final hostIP = '10.0.2.2';
  static final String hostUrlDevelop = 'https://10.0.2.2:5001/api/v1/';
  var tokenCurrentTime = DateTime.now().millisecondsSinceEpoch;

  String getUrl(String params) {

    if (params == null) {
      return '$hostIP';
    }
    return '$hostUrlDevelop$params';
  }

  Future<void> setHeaders(HttpClientRequest request) async {
    var preferences = await SharedPreferences.getInstance();
    request.headers.set('Content-type', 'application/json');

    if (preferences.containsKey("tokenJWT")) {
      String tokenJWT = preferences.getString('tokenJWT');
      request.headers.add('Authorization', 'Bearer $tokenJWT');
    }
  }
}
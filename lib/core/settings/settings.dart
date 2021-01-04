import 'dart:io';

import 'package:healthsup/core/authentication/authentication.dart';

class Settings {
  static final hostIP = '10.0.2.2';
  static final String hostUrlDevelop = 'https://10.0.2.2:5001/api/v1/';
  var tokenCurrentTime = DateTime.now().millisecondsSinceEpoch;

  String getUrl(String params) {
    if (params == null) {
      return '$hostIP';
    }
    return '$hostUrlDevelop$params';
  }

  Future<void> certificateHost(HttpClient client) async {
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == getUrl(null);
      return isValidHost;
    });
  }

  Future<void> setHeaders(HttpClientRequest request) async {
    request.headers.set('Content-type', 'application/json');
  }

  Future<void> setToken(HttpClientRequest request) async {
    AuthenticationSettings authentication = new AuthenticationSettings();

    String tokenJWT = await authentication.getToken();
    request.headers.add('Authorization', 'Bearer $tokenJWT');
  }
}

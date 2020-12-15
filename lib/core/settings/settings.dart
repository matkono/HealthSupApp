import 'dart:io';

import 'package:HealthSup/core/authentication/authentication.dart';

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

    // String tokenJWT = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDc5NzE1MDQsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0Mzc4IiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzNzgifQ.JG68fAHrcDToNHXwfZLW5ARBWhuVcvZ9Ivesw8kY3Lw';
    String tokenJWT = await authentication.getToken();
    request.headers.add('Authorization', 'Bearer $tokenJWT');
  }
}

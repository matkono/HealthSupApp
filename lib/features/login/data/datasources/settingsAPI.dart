import 'dart:io';

import 'package:HealthSup/core/authentication/authentication.dart';

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
    Authentication authentication;

    // String tokenJWT = await authentication.getToken();

    request.headers.set('Content-type', 'application/json');
    String tokenJWT = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDc0NzExNDAsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0Mzc4IiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzNzgifQ.b-VYrN1eM6pYEHUJfG0QzoNFQ4RNtw-Fifz3EKCuUgE';
    request.headers.add('Authorization', 'Bearer $tokenJWT');
  }
}
// import 'dart:io';

// import 'package:HealthSup/core/authentication/authentication.dart';

// class Settings {
//   static final hostIP = '10.0.2.2';
//   static final String hostUrlDevelop = 'https://10.0.2.2:5001/api/v1/';
//   var tokenCurrentTime = DateTime.now().millisecondsSinceEpoch;

//   Future<Map<dynamic, dynamic>> authenticatorAPI(
//       AuthenticateApiModel user) async {
//     try {
//       HttpClient client = new HttpClient();
//       client.badCertificateCallback =
//           ((X509Certificate cert, String host, int port) {
//         final isValidHost = host == settingsAPI.getUrl(null);
//         return isValidHost;
//       });

//       String urlAuth = 'Authentication/agentAuthentication/token/';
//       Map map = user.toJson();

//       var url = settingsAPI.getUrl(urlAuth);
//       print(url);
//       var uriParse = Uri.parse(url);
//       print(uriParse);
//       HttpClientRequest request =
//           await client.postUrl(uriParse).timeout(Duration(seconds: 10));
//       await settingsAPI.setHeaders(request);
//       request.add(utf8.encode(json.encode(map)));

//       HttpClientResponse response = await request.close();
//       String body = await response.transform(utf8.decoder).join();
//       print(body);
//       Map jsonDecoded = json.decode(body);

//       return jsonDecoded;
//     } on TimeoutException catch (e) {
//       throw e;
//     } on SocketException catch (e) {
//       throw e;
//     } on Exception catch (_) {
//       throw ServerException();
//     }
//   }

//   String getUrl(String params) {

//     if (params == null) {
//       return '$hostIP';
//     }
//     return '$hostUrlDevelop$params';
//   }

//   Future<void> setHeaders(HttpClientRequest request) async {
//     Authentication authentication;

//     String tokenJWT = await authentication.getToken();

//     request.headers.set('Content-type', 'application/json');
//     request.headers.add('Authorization', 'Bearer $tokenJWT');
//   }
// }
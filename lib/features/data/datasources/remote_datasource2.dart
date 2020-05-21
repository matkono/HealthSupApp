import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cardiompp/features/data/models/loginAPI_model.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@override
class CustomCacheManager extends BaseCacheManager {
  static const key = 'jsonCache';

  CustomCacheManager() : super(key);

  @override
  Future<String> getFilePath() async {
    var dir = await getTemporaryDirectory();

    return path.join(dir.path, key);
  }
}

abstract class DoctorRemoteDataSource {
  Future<bool> getLoginDataFromAPI(String email, String password);
  Future<void> downloadToCache();
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  var currentTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  Future<void> authenticatorAPI(LoginAPIModel user) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == "10.0.2.2";
      return isValidHost;
    });

    String urlAuth = 'https://10.0.2.2:5001/api/v1/authentication/';

    Map map = user.toJson();

    HttpClientRequest request = await client.postUrl(Uri.parse(urlAuth));

    request.headers.set('Content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));


    HttpClientResponse response = await request.close();

    String body = await response.transform(utf8.decoder).join();

    var jsonDecoded = json.decode(body);

    setSharedPreferences(jsonDecoded);
  }

  Future<void> setSharedPreferences(Map<String, dynamic> bodyResponse) async {
    var preferences = await SharedPreferences.getInstance();
    var token = bodyResponse['data']['token'];

    preferences.setString('tokenJWT', token);
    preferences.setString('currentTime', currentTime);
  }

  Future<String> getSharedPreferences() async {
    var preferences = await SharedPreferences.getInstance();

    var getToken = preferences.getString('tokenJWT');

    return getToken;
  }

  // Future<String> authenticationAPI(LoginAPIModel user) async {

  //   HttpClient client = new HttpClient();
  //   client.badCertificateCallback = ((X509Certificate cert, String host, int port) {
  //     final isValidHost = host == "10.0.2.2";
  //     return isValidHost;
  //     });

  //   String url ='https://10.0.2.2:5001/api/v1/authentication/';

  //   var header = {
  //     'accept': '*/*',
  //     'Content-type': 'application/json',
  //   };

  //   Map map = {
  //     "agentName" : "CardiomppApp" ,
  //     "password" : "2e0f011c-a22d-4771-8c50-a9491b96dfea"
  //   };

  //   var request = await http.post(url, headers: header, body: json.encode(map));

  //   var body = request.body;

  //   var cookie = new ClientCookie('token', 'token',
  //   new DateTime.now());

  //   print('Cookie');
  //   print(cookie);

  //   return body;
  // }

  @override
  Future<bool> getLoginDataFromAPI(String email, String password) async {
     var client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == "10.0.2.2";
      return isValidHost;
    });

    var loginAPIModel = new LoginAPIModel(
        agentName: 'CardiomppApp',
        password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
    );

    String urlLogin ='https://10.0.2.2:5001/api/v1/Doctor/login';
    
    await authenticatorAPI(loginAPIModel);
    

    String tokenJWT = await getSharedPreferences();

    Map login = {
      'email': email,
      'password': password,
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(urlLogin));

    print('Token JWT: $tokenJWT');

    request.headers.set('Content-type', 'application/json');
    request.headers.add('Authorization', 'Bearer  $tokenJWT');
    request.add(utf8.encode(json.encode(login)));

    HttpClientResponse response = await request.close();

    var body = await response.transform(utf8.decoder).join();
    var jsonLoginResponse = json.decode(body);

    print('statusCode: ' + response.statusCode.toString());
    print('body: ' + body);

    if (response.statusCode == 200) {
      if (jsonLoginResponse['success'] == true && jsonLoginResponse['errors'] == null) {
        return true;
      }
    } else {
      return false;
    }
  }

  @override
  Future<void> downloadToCache() async {
    var cacheManager = CustomCacheManager();
    var urlCache = 'Url do Json para a Cache';
    var fetchedFile = await cacheManager.downloadFile(urlCache);

    return await fetchedFile.file.rename(
        '/data/user/0/com.example.mobilecache/cache/jsonCache/myJson.json');
  }
}

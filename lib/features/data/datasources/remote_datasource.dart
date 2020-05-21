import 'dart:convert';
import 'dart:io';
import 'package:cardiompp/features/data/datasources/settingsAPI.dart';
import 'package:intl/intl.dart';
import 'package:cardiompp/features/data/models/loginAPI_model.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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
  var currentTime = DateTime.now().millisecondsSinceEpoch;
  final SettingsAPI settingsAPI = new SettingsAPI();

  Future<void> authenticatorAPI(LoginAPIModel user) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) {
      final isValidHost = host == "10.0.2.2";
      return isValidHost;
    });

    String urlAuth = 'api/v1/authentication/';
    Map map = user.toJson();

    HttpClientRequest request = await client.postUrl(Uri.parse(settingsAPI.getUrl(urlAuth)));

    await settingsAPI.setHeaders(request);
    request.add(utf8.encode(json.encode(map)));

    HttpClientResponse response = await request.close();

    String body = await response.transform(utf8.decoder).join();
    var jsonDecoded = json.decode(body);

    await settingsAPI.setSharedPreferences(jsonDecoded);
  }

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
    
    String tokenJWT = await settingsAPI.getTokenSharedPreferences('tokenJWT');

    if (tokenJWT == null) {
      print('Entrou aqui');
      await authenticatorAPI(loginAPIModel);
    } else if (settingsAPI.getTokenSharedPreferences('tokenJWT') != null) {
        bool validateToken = await settingsAPI.validateTokenTime('tokenCurrentTime');
        print(validateToken);
        if (validateToken == true) {
          await settingsAPI.resetSharedPreferences();
          await authenticatorAPI(loginAPIModel);
        }
    }

    Map login = {
      'email': email,
      'password': password,
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(urlLogin));

    tokenJWT = await settingsAPI.getTokenSharedPreferences('tokenJWT');
    print('Token JWT: $tokenJWT');

    await settingsAPI.setHeaders(request);
    request.add(utf8.encode(json.encode(login)));

    HttpClientResponse response = await request.close();

    var body = await response.transform(utf8.decoder).join();
    var jsonLoginResponse = json.decode(body);

    print('statusCode: ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      print('body: ' + body);
      if (jsonLoginResponse['success'] == true && jsonLoginResponse['errors'] == null) {
        return true;
      }
    }
    if (response.statusCode == 400) {
      print(jsonLoginResponse['errors']);
    }
    return false;
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

import 'dart:convert';
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
  // Future<DoctorModel> getDoctorData(String crm, String email, String password);
  Future<bool> getLoginDataFromAPI(String crm, String email, String password);
  Future<void> downloadToCache();
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final url = 'https://my-json-server.typicode.com/ShibaharaLH/TesteTCC/posts';

  @override
  Future<bool> getLoginDataFromAPI(
    String crm, String email, String password) async {
      final response = await http.get(url);
      if(response.statusCode == 200) {
        var res = json.decode(response.body);
        if(res[0]['success'] == true) {
          return true;
        }
        print("Ocorreu um erro");
      }
      return false;
    }

  @override
  Future<void> downloadToCache() async {
    var cacheManager = CustomCacheManager();
    var fetchedFile = await cacheManager.downloadFile(url);

    return await fetchedFile.file.rename(
        '/data/user/0/com.example.mobilecache/cache/jsonCache/myJson.json');
  }
}
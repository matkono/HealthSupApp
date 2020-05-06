import 'dart:convert';
import 'dart:io';
import 'package:mobilecache/features/data/models/question_model.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

Future<File> _localPath() async {

  var cacheManager = CustomCacheManager();

  final cache = cacheManager.getFilePath();
  var filePath = cache;
  print('Should return the instance of class that contain the path');
  print(filePath);
  return File(
      '/data/user/0/com.example.mobilecache/cache/jsonCache/myJson.json');
}

  Future<List<QuestionModel>> readJsonFile() async {
    final file = await _localPath();
    var archive = List<QuestionModel>();

    String contents = await file.readAsString();

    var notesJson = json.decode(contents);
    for (var noteJson in notesJson) {
      archive.add(QuestionModel.fromJson(noteJson));
    }
    return archive;
  }

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
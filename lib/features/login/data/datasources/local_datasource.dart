import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<String> getTokenSharedPreferences(String key);
  Future<int> getTimeTokenSharedPreferences(String key);
  Future<void> setSharedPreferences(Map<String, dynamic> bodyResponse);
  Future<bool> validateTokenTime(String key);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  static final preferences = SharedPreferences.getInstance();
  var tokenCurrentTime = DateTime.now().millisecondsSinceEpoch;

  @override
  Future<String> getTokenSharedPreferences(String key) async {
    var preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(key)) {
      var getToken = preferences.getString(key);
  
      return getToken;
    }
    return null;
  }

  @override
  Future<int> getTimeTokenSharedPreferences(String key) async {
    var preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(key)) {
      int getToken = preferences.getInt(key);
  
      return getToken;
    }
    return null;
  }

  @override
  Future<void> setSharedPreferences(Map<String, dynamic> bodyResponse) async {
    var preferences = await SharedPreferences.getInstance();
    var token = bodyResponse['data']['token'];
    preferences.setString('tokenJWT', token);
    preferences.setInt('tokenCurrentTime', tokenCurrentTime);
  }

  Future<bool> validateTokenTime(String key) async {
    var preferences = await SharedPreferences.getInstance();
    var timeNow = DateTime.now().millisecondsSinceEpoch;

    if (preferences.containsKey(key)) {
      var tokenTime = preferences.getInt(key);

      if (timeNow - tokenTime > 29*60*1000) {
        return true;
      }
    }
    return false;
  }
}
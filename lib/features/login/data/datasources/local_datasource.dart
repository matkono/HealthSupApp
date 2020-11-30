import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<String> getTokenSharedPreferences(String key);
  Future<int> getTimeTokenSharedPreferences(String key);
  Future<void> setSharedPreferences(Map<String, dynamic> bodyResponse);
  Future<bool> validateTokenTime(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  static final preferences = SharedPreferences.getInstance();
  static final hostIP = '10.0.2.2';
  static final String hostUrlDevelop = 'https://10.0.2.2:5001/api/v1/';
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

  Future<void> resetSharedPreferences() async {
    var preferences = await SharedPreferences.getInstance();

    preferences.clear();
  }

}
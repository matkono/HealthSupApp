import 'package:HealthSup/core/authentication/model/authentication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationSettings {
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var tokenCurrentTime = DateTime.now().millisecondsSinceEpoch;
  var loginAPIModel = new AuthenticationModel(
    agentKey: 'db39648a-14f5-406f-94d8-1b43d266f1dd',
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  Future<void> setSharedPreferences(Map<String, dynamic> bodyResponse) async {
    var preferences = await SharedPreferences.getInstance();
    var token = bodyResponse['data']['token'];
    preferences.setString('tokenJWT', token);
    preferences.setInt('tokenCurrentTime', tokenCurrentTime);
  }

  Future<bool> verifyToken() async {
    var preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey(tokenKey.toString())) {
      var expiredToken = await validateTokenTime(tokenTimeKey.toString());

      if (expiredToken == true) {
        await resetSharedPreferences();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    var preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey("tokenJWT")) {
      String tokenJWT = preferences.getString('tokenJWT');
      return tokenJWT;
    } else
      return 'Token inválido';
  }

  Future<bool> validateTokenTime(String key) async {
    var preferences = await SharedPreferences.getInstance();
    var timeNow = DateTime.now().millisecondsSinceEpoch;

    if (preferences.containsKey(key)) {
      var tokenTime = preferences.getInt(key);

      if (timeNow - tokenTime > 29 * 60 * 1000) {
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

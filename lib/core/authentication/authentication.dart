import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  
  Future<String> getToken() async {
    var preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey("tokenJWT")) {
      String tokenJWT = preferences.getString('tokenJWT');
      return tokenJWT;
    }
    else
    return 'Token inválido';
  }
}
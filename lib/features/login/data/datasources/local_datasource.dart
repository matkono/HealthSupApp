import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<int> getUserID();
  Future<bool> saveUserID(int id);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String USER_ID_KEY = 'USER_ID_KEY';

  LoginLocalDataSourceImpl({
    @required this.sharedPreferences,
  });

  @override
  Future<int> getUserID() async {
    if (sharedPreferences.containsKey(USER_ID_KEY)) {
      int getID = sharedPreferences.getInt(USER_ID_KEY);

      return getID;
    }
    return null;
  }

  @override
  Future<bool> saveUserID(int id) async {
    return await sharedPreferences.setInt(USER_ID_KEY, id);
  }
}

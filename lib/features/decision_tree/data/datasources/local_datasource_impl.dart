import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DecisionTreeLocalDataSource {
  Future<int> getAppointmentID();
  Future<bool> saveAppointmentID(int id);
}

class DecisionTreeLocalDataSourceImpl implements DecisionTreeLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String APPOINTMENT_ID_KEY = 'APPOINTMENT_ID_KEY';

  DecisionTreeLocalDataSourceImpl({
    @required this.sharedPreferences,
  });

  @override
  Future<int> getAppointmentID() async {
    if (sharedPreferences.containsKey(APPOINTMENT_ID_KEY)) {
      int getID = sharedPreferences.getInt(APPOINTMENT_ID_KEY);

      return getID;
    }
    return null;
  }

  @override
  Future<bool> saveAppointmentID(int id) async {
    return await sharedPreferences.setInt(APPOINTMENT_ID_KEY, id);
  }
}

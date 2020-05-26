import 'package:cardiompp/core/error/exception.dart';
import 'package:cardiompp/core/error/failure.dart';
import 'package:cardiompp/features/data/datasources/local_datasource.dart';
import 'package:cardiompp/features/data/datasources/remote_datasource.dart';
import 'package:cardiompp/features/data/models/authenticateAPI_model.dart';
import 'package:cardiompp/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorRepositoryImpl implements Repository {
  var doctorRemoteDataSource = new DoctorRemoteDataSourceImpl();
  var localDataSource = new LocalDataSourceImpl();
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var loginAPIModel = new LoginAPIModel(
    agentName: 'CardiomppApp',
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  @override
  Future<bool> authenticationAPI(String email, String password) async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(tokenKey)) {
      var expiredToken = await localDataSource.validateTokenTime(tokenTimeKey);
      
      if(expiredToken == true) {
        await localDataSource.resetSharedPreferences();
        var responseBodyAPI = await doctorRemoteDataSource.authenticatorAPI(loginAPIModel);
        await localDataSource.setSharedPreferences(responseBodyAPI);
        var token = await localDataSource.getTokenSharedPreferences('tokenJWT');
        print('Token JWT: $token');
        return doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences);
      }
      return doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences);
    }
    var responseBodyAPI = await doctorRemoteDataSource.authenticatorAPI(loginAPIModel);
    await localDataSource.setSharedPreferences(responseBodyAPI);
    return doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences);
  }
}
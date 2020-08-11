import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/features/login/data/datasources/local_datasource.dart';
import 'package:HealthSup/features/login/data/datasources/remote_datasource.dart';
import 'package:HealthSup/features/login/data/models/authenticateAPI_model.dart';
import 'package:HealthSup/features/login/domain/entities/doctor.dart';
import 'package:HealthSup/features/login/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorRepositoryImpl implements Repository {
  var doctorRemoteDataSource = new DoctorRemoteDataSourceImpl();
  var localDataSource = new LocalDataSourceImpl();
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var loginAPIModel = new AuthenticateApiModel(
    agentName: 'CardiomppApp',
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  @override
  Future<Either<Failure, Doctor>> authenticationAPI(String email, String password) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      if (preferences.containsKey(tokenKey)) {
        var expiredToken = await localDataSource.validateTokenTime(tokenTimeKey);
        if(expiredToken == true) {
          await localDataSource.resetSharedPreferences();
          var responseBodyAPI = await doctorRemoteDataSource.authenticatorAPI(loginAPIModel);
          await localDataSource.setSharedPreferences(responseBodyAPI);
          return Right(await doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences));
        }
        final fromDoctorModel = await doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences);
        final toDoctor = new Doctor(
          crm: fromDoctorModel.crm, email: fromDoctorModel.email, isActive: fromDoctorModel.isActive);
        return Right(toDoctor);
      }
      var responseBodyAPI = await doctorRemoteDataSource.authenticatorAPI(loginAPIModel);
      await localDataSource.setSharedPreferences(responseBodyAPI);
      return Right(await doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences));
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }
}
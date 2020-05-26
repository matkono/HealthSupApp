// login_bloc

  Future<Either<Failure, Doctor>> loginDoctor(String email, String password) {
    return Future.delayed(Duration(seconds: 1), () async {
      var useCase = DoctorUseCase();
      print("<<< AuthenticationAPI >>>");

      final result = await useCase.call(Params(email: email, password: password));
      // print('$result');

      if(result.isRight() == true) {
        print('$result');
        return Right(Doctor(email: email));
      }
      return Left(ServerFailure());
    });

// repository_Impl

  @override
  Future<Either<Failure, bool>> authenticationAPI(String email, String password) async {
    final preferences = await SharedPreferences.getInstance();

    try {

      if (preferences.containsKey(tokenKey)) {
        var expiredToken = await localDataSource.validateTokenTime(tokenTimeKey);
        
        if(expiredToken == true) {
          await localDataSource.resetSharedPreferences();
          var responseBodyAPI = await doctorRemoteDataSource.authenticatorAPI(loginAPIModel);
          await localDataSource.setSharedPreferences(responseBodyAPI);
          var token = await localDataSource.getTokenSharedPreferences('tokenJWT');
          print('Token JWT: $token');
          final remoteControl = await doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences);
          return Right(remoteControl);
        }
        final remoteControl = await doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences);
        return Right(remoteControl);
      }
      var responseBodyAPI = await doctorRemoteDataSource.authenticatorAPI(loginAPIModel);
      await localDataSource.setSharedPreferences(responseBodyAPI);
      final remoteControl = await doctorRemoteDataSource.getLoginDataFromAPI(email, password, preferences);
      return Right(remoteControl);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
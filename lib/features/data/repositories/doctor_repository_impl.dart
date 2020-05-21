import 'package:cardiompp/features/data/datasources/remote_datasource.dart';
import 'package:cardiompp/features/domain/repositories/repository.dart';

class DoctorRepositoryImpl implements Repository {
  @override
  Future<void> downloadFileToCache() {
    DoctorRemoteDataSourceImpl remoteDataSource;

    return remoteDataSource.downloadToCache();
  }

  @override
  Future<bool> getLoginDataFromDataSource(String email, String password) {
    DoctorRemoteDataSourceImpl doctorRemoteDataSource =
        new DoctorRemoteDataSourceImpl();
    return doctorRemoteDataSource.getLoginDataFromAPI(email, password);
  }
}

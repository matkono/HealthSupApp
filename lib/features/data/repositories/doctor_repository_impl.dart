import 'package:dartz/dartz.dart';
import 'package:mobilecache/core/error/failure.dart';
import 'package:mobilecache/features/data/datasources/doctor_remote_datasource.dart';
import 'package:mobilecache/features/domain/entities/doctor.dart';
import 'package:mobilecache/features/domain/repositories/doctor_repository.dart';

typedef Future<Doctor> ModelToUser();

class DoctorRepositoryImpl implements DoctorRepository {


  Future<Either<Failure, Doctor>> _getData(
    ModelToUser modelToUser,
  ) async {
    if (true) {
      try {
        final remoteData = await modelToUser();
        return Right(remoteData);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> downloadFileToCache() {
    DoctorRemoteDataSourceImpl doctorRemoteDataSource;

    return doctorRemoteDataSource.downloadToCache();
  }

  @override
  Future<bool> getLoginDataFromRepository(String crm, String email, String password) {
    DoctorRemoteDataSourceImpl doctorRemoteDataSource = new DoctorRemoteDataSourceImpl();
    return doctorRemoteDataSource.getLoginDataFromAPI(crm, email, password);
  }
}
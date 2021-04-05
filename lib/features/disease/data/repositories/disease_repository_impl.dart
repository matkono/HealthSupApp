import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/exception.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/disease/data/datasources/disease_remote_datasource.dart';
import 'package:healthsup/features/disease/data/models/pagination_model.dart';
import 'package:healthsup/features/disease/domain/entities/diseases_list.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';
import 'package:healthsup/features/disease/domain/repositories/disease_repository.dart';

class DiseaseRepositoryImpl implements DiseaseRepository {
  final DiseaseRemoteDataSource remoteDataSource;

  DiseaseRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, DiseasesList>> getDiseaseList(
      Pagination pagination) async {
    try {
      final fromEntity = PaginationModel.fromEntity(pagination);
      final sendPagination = await remoteDataSource.getDiseaseList(fromEntity);
      return Right(sendPagination);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}

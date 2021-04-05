import 'package:dartz/dartz.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/disease/domain/entities/diseases_list.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';

abstract class DiseaseRepository {
  Future<Either<Failure, DiseasesList>> getDiseaseList(Pagination pagination);
}

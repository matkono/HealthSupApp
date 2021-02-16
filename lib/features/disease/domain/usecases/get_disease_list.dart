import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/core/usecase/usecase.dart';
import 'package:healthsup/features/disease/domain/entities/diseases_list.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';
import 'package:healthsup/features/disease/domain/repositories/disease_repository.dart';

class GetDiseaseList extends UseCase<DiseasesList, ParamsDiseaseInfo> {
  final DiseaseRepository diseaseRepository;

  GetDiseaseList(
    this.diseaseRepository,
  );

  @override
  Future<Either<Failure, DiseasesList>> call(ParamsDiseaseInfo params) async {
    return await diseaseRepository.getDiseaseList(params.pagination);
  }
}

class ParamsDiseaseInfo extends Equatable {
  final Pagination pagination;

  ParamsDiseaseInfo({
    @required this.pagination,
  });

  @override
  List<Object> get props => [pagination];
}

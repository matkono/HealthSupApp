import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/disease/domain/entities/diseases.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';
import 'package:healthsup/features/disease/domain/usecases/get_disease_list.dart';

part 'disease_event.dart';
part 'disease_state.dart';

class DiseaseBloc extends Bloc<DiseaseEvent, DiseaseState> {
  List<Diseases> diseaseList = [];
  final GetDiseaseList getDiseaseList;
  Pagination currentPagination;

  DiseaseBloc({
    @required this.getDiseaseList,
  }) : super(DiseaseInitial()) {
    this.add(GetNextDiseaseListEvent());
  }

  @override
  Stream<DiseaseState> mapEventToState(
    DiseaseEvent event,
  ) async* {
    if (event is GetNextDiseaseListEvent) {
      yield DiseaseLoading();

      if (currentPagination == null) {
        currentPagination = new Pagination(pageNumber: 1, pageSize: 10);
      } else {
        currentPagination = new Pagination(
            pageNumber: currentPagination.pageNumber + 1,
            pageSize: currentPagination.pageSize);
      }

      var failureOrList = await getDiseaseList(
          ParamsDiseaseInfo(pagination: currentPagination));
      yield failureOrList.fold(
        (failure) {
          if (failure is ServerFailure) {
            return ErrorDiseaseState(message: failure.failureMessage);
          } else if (failure is NoInternetConnectionFailure) {
            return ErrorDiseaseState(message: failure.failureMessage);
          } else {
            return ErrorDiseaseState(message: 'Erro desconhecido');
          }
        },
        (diseaseResult) {
          if (diseaseResult.diseases == null) {
            return ErrorDiseaseState(message: 'Doenças não encontradas!');
          } else {
            if (diseaseResult.pageNumber == 0) {
              diseaseList.clear();
            }
            diseaseList.addAll(diseaseResult.diseases);
            return DiseaseLoaded(
                diseasesList: diseaseList, totalRows: diseaseResult.totalRows);
          }
        },
      );
    } else if (state is GetStartDiseaseListEvent) {
      yield DiseaseLoading();

      currentPagination = null;

      this.add(GetNextDiseaseListEvent());
    }
  }
}

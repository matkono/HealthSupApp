part of 'disease_bloc.dart';

abstract class DiseaseEvent extends Equatable {
  const DiseaseEvent();

  @override
  List<Object> get props => [];
}

class GetStartDiseaseListEvent extends DiseaseEvent {}

class GetNextDiseaseListEvent extends DiseaseEvent {}

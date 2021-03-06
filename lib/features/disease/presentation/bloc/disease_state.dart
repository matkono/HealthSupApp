part of 'disease_bloc.dart';

abstract class DiseaseState extends Equatable {
  const DiseaseState();

  @override
  List<Object> get props => [];
}

class DiseaseInitial extends DiseaseState {
  @override
  List<Object> get props => [];
}

class ErrorDiseaseState extends DiseaseState {
  final String message;

  ErrorDiseaseState({
    this.message = 'Erro ao listar doenças!',
  });

  @override
  List<Object> get props => [message];
}

class DiseaseLoaded extends DiseaseState {
  final List<Diseases> diseasesList;
  final int totalRows;

  DiseaseLoaded({
    @required this.diseasesList,
    @required this.totalRows,
  });

  @override
  List<Object> get props => [diseasesList, totalRows];
}

class DiseaseLoading extends DiseaseState {}

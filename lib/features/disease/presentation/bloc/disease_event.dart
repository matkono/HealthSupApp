part of 'disease_bloc.dart';

abstract class DiseaseEvent extends Equatable {
  const DiseaseEvent();

  @override
  List<Object> get props => [];
}

class GetStartDiseaseListEvent extends DiseaseEvent {}

class GetNextDiseaseListEvent extends DiseaseEvent {}

class StartNewDiseaseEvent extends DiseaseEvent {
  final int patientId;
  final int diseaseId;

  StartNewDiseaseEvent({
    @required this.patientId,
    @required this.diseaseId,
  });

  @override
  List<Object> get props => [patientId, diseaseId];
}

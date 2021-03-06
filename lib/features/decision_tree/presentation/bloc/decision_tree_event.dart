part of 'decision_tree_bloc.dart';

abstract class DecisionTreeEvent extends Equatable {
  const DecisionTreeEvent();
}

class StartDecisionTreeEvent extends DecisionTreeEvent {
  final int patientId;
  final int diseaseId;

  StartDecisionTreeEvent({
    @required this.patientId,
    @required this.diseaseId,
  });

  @override
  List<Object> get props => [patientId, diseaseId];
}

class GetCurrentNodeDecisionTreeEvent extends DecisionTreeEvent {
  final int idAppointmment;

  GetCurrentNodeDecisionTreeEvent({
    this.idAppointmment,
  });

  @override
  List<Object> get props => [];
}

class GetNextNodeDecisionTreeEvent extends DecisionTreeEvent {
  final Answer answer;

  GetNextNodeDecisionTreeEvent({
    @required this.answer,
  });

  @override
  List<Object> get props => [answer];
}

class GetPreviousNodeDecisionTreeEvent extends DecisionTreeEvent {
  final int idNode;

  GetPreviousNodeDecisionTreeEvent({
    @required this.idNode,
  });

  @override
  List<Object> get props => [idNode];
}

class ConfirmDecisionDecisionTreeEvent extends DecisionTreeEvent {
  @override
  List<Object> get props => [];
}

class ConfirmActionDecisionTreeEvent extends DecisionTreeEvent {
  final int idAction;

  ConfirmActionDecisionTreeEvent({
    @required this.idAction,
  });

  @override
  List<Object> get props => [idAction];
}

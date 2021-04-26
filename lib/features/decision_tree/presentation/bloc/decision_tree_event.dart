part of 'decision_tree_bloc.dart';

abstract class DecisionTreeEvent extends Equatable {
  const DecisionTreeEvent();

  @override
  List<Object> get props => [];
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
  final int idAppointment;

  GetPreviousNodeDecisionTreeEvent({
    @required this.idNode,
    @required this.idAppointment,
  });

  @override
  List<Object> get props => [idNode, idAppointment];
}

class ConfirmDecisionDecisionTreeEvent extends DecisionTreeEvent {
  final int idAppointment;
  final int idDecision;

  ConfirmDecisionDecisionTreeEvent({
    @required this.idAppointment,
    @required this.idDecision,
  });

  @override
  List<Object> get props => [idAppointment, idDecision];
}

class ConfirmActionDecisionTreeEvent extends DecisionTreeEvent {
  final int idAction;
  final int idAppointment;

  ConfirmActionDecisionTreeEvent({
    @required this.idAction,
    @required this.idAppointment,
  });

  @override
  List<Object> get props => [idAction, idAppointment];
}

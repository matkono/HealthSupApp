part of 'decision_tree_bloc.dart';

abstract class DecisionTreeState extends Equatable {
  const DecisionTreeState();
}

class DecisionTreeInitial extends DecisionTreeState {
  @override
  List<Object> get props => [];
}

class QuestionDecisionTreeState extends DecisionTreeState {
  final Node node;
  final int idAppointment;

  QuestionDecisionTreeState({
    @required this.node,
    @required this.idAppointment,
  });

  @override
  List<Object> get props => [node];
}

class DecisionDecisionTreeState extends DecisionTreeState {
  final Node node;
  final int idAppointment;

  DecisionDecisionTreeState({
    @required this.node,
    @required this.idAppointment,
  });

  @override
  List<Object> get props => [node, idAppointment];
}

class ActionDecisionTreeState extends DecisionTreeState {
  final Node node;
  final int idAppointment;

  ActionDecisionTreeState({
    @required this.node,
    @required this.idAppointment,
  });

  @override
  List<Object> get props => [node, idAppointment];
}

class LoadingDecisionTreeState extends DecisionTreeState {
  @override
  List<Object> get props => [];
}

class ErrorDecisionTreeState extends DecisionTreeState {
  final String message;
  final int idAppointment;

  ErrorDecisionTreeState({
    @required this.message,
    this.idAppointment,
  });

  @override
  List<Object> get props => [message, idAppointment];
}

class AppointmentFinished extends DecisionTreeState {
  @override
  List<Object> get props => [];
}

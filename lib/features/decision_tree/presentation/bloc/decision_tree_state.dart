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

  QuestionDecisionTreeState({
    @required this.node,
  });

  @override
  List<Object> get props => [node];
}

class DecisionDecisionTreeState extends DecisionTreeState {
  final Node node;

  DecisionDecisionTreeState({
    @required this.node,
  });

  @override
  List<Object> get props => [node];
}

class ActionDecisionTreeState extends DecisionTreeState {
  final Node node;

  ActionDecisionTreeState({
    @required this.node,
  });

  @override
  List<Object> get props => [node];
}

class LoadingDecisionTreeState extends DecisionTreeState {
  @override
  List<Object> get props => [];
}

class ErrorDecisionTreeState extends DecisionTreeState {
  final String message;

  ErrorDecisionTreeState({@required this.message});

  @override
  List<Object> get props => [message];
}

class AppointmentFinished extends DecisionTreeState {
  @override
  List<Object> get props => [];
}
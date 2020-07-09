part of 'decision_tree_bloc.dart';

abstract class DecisionTreeEvent extends Equatable {
  const DecisionTreeEvent();
}

class InitialDecisionTreeEvent extends DecisionTreeEvent {
  @override
  List<Object> get props => [];
}

class StartDecisionTreeEvent extends DecisionTreeEvent {
  @override
  List<Object> get props => [];
}

class NextNodeDecisionTreeEvent extends DecisionTreeEvent {
  final Answer answer;

  NextNodeDecisionTreeEvent({
    @required this.answer,
  });

  @override
  List<Object> get props => [answer];
}

class LastNodeDecisionTreeEvent extends DecisionTreeEvent {
  final int idQuestion;

  LastNodeDecisionTreeEvent({
    @required this.idQuestion,
  });

  @override
  List<Object> get props => [idQuestion];
}
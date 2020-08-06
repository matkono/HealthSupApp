part of 'decision_tree_bloc.dart';

abstract class DecisionTreeState extends Equatable {
  const DecisionTreeState();
}

class DecisionTreeInitial extends DecisionTreeState {
  @override
  List<Object> get props => [];
}

class LoadedDecisionTreeState extends DecisionTreeState {
  final Node node;

  LoadedDecisionTreeState({
    @required this.node,
  });

  @override
  List<Object> get props => [node];
}

class StartDecisionTreeState extends DecisionTreeState {
  final Node node;

  StartDecisionTreeState({
    @required this.node,
  });

  @override
  List<Object> get props => [node];
}

class IsLoadingDecisionTreeState extends DecisionTreeState {
  @override
  List<Object> get props => [];
}

class ErrorDecisionTreeState extends DecisionTreeState {
  @override
  List<Object> get props => ['Failure'];
}
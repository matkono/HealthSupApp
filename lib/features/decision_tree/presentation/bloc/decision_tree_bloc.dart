import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cardiompp/core/usecase/usecase.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/node.dart';
import 'package:cardiompp/features/decision_tree/domain/usecases/last_question.dart';
import 'package:cardiompp/features/decision_tree/domain/usecases/send_answer.dart';
import 'package:cardiompp/features/decision_tree/domain/usecases/start_medical_appointment.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'decision_tree_event.dart';
part 'decision_tree_state.dart';

class DecisionTreeBloc extends Bloc<DecisionTreeEvent, DecisionTreeState> {
  @override
  DecisionTreeState get initialState => DecisionTreeInitial();

  @override
  Stream<DecisionTreeState> mapEventToState(
    DecisionTreeEvent event,
  ) async* {
    

    if (event is StartDecisionTreeEvent) {
      final string = new StartMedicalAppointment();
      final firstQuestion = await string.call(NoParams());
      final Node nodeTree = firstQuestion.getOrElse(() => null);

      if (firstQuestion.isRight()) {
        print(nodeTree.question.title);
        yield LoadedDecisionTreeState(node: nodeTree);
      } else {
        print('Failure');
        yield ErrorDecisionTreeState();
      }
    } else if (event is InitialDecisionTreeEvent) {

      yield DecisionTreeInitial();

    } else if (event is NextNodeDecisionTreeEvent) {

      final string = new SendAnswer();
      final firstQuestion = await string.call(ParamsAnswer(answer: event.answer));
      final Node nodeTree = firstQuestion.getOrElse(() => null);
      yield LoadedDecisionTreeState(node: nodeTree);

    } else if (event is LastNodeDecisionTreeEvent) {

      final lastNode = new LastQuestion();
      final lastQuestion = await lastNode.call(ParamsQuestion(idQuestion: event.idQuestion));
      final Node lastNodeTree = lastQuestion.getOrElse(() => null);
      yield LoadedDecisionTreeState(node: lastNodeTree);
    }
  }
}

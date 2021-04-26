import 'dart:async';

import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/decision_tree/domain/entities/answer.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:healthsup/features/decision_tree/domain/usecases/confirm_action.dart';
import 'package:healthsup/features/decision_tree/domain/usecases/finish_appointment.dart';
import 'package:healthsup/features/decision_tree/domain/usecases/get_current_node.dart';
import 'package:healthsup/features/decision_tree/domain/usecases/previous_question.dart';
import 'package:healthsup/features/decision_tree/domain/usecases/send_answer.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:healthsup/features/decision_tree/domain/usecases/start_new_disease.dart';

part 'decision_tree_event.dart';
part 'decision_tree_state.dart';

class DecisionTreeBloc extends Bloc<DecisionTreeEvent, DecisionTreeState> {
  final ConfirmAction confirmAction;
  final FinishAppointment finishAppointment;
  final GetCurrentNode getCurrentNode;
  final PreviousQuestion previousQuestion;
  final SendAnswer sendAnswer;
  final StartNewDisease startNewDisease;

  DecisionTreeBloc({
    @required this.confirmAction,
    @required this.finishAppointment,
    @required this.getCurrentNode,
    @required this.previousQuestion,
    @required this.sendAnswer,
    @required this.startNewDisease,
  }) : super(DecisionTreeInitial());

  @override
  Stream<DecisionTreeState> mapEventToState(
    DecisionTreeEvent event,
  ) async* {
    if (event is StartDecisionTreeEvent) {
      yield LoadingDecisionTreeState();

      var failureOrMedicalAppointment = await startNewDisease(
          ParamsStartNewDisease(
              patientId: event.patientId, diseaseId: event.diseaseId));
      if (failureOrMedicalAppointment.isRight()) {
        var teste = failureOrMedicalAppointment.fold(
          (failure) => null,
          (appointment) => appointment.id,
        );
        var failureOrNode = await getCurrentNode(
          ParamsCurrentNode(
            idAppointment: failureOrMedicalAppointment.fold(
              (failure) => null,
              (medicalAppointment) {
                return medicalAppointment.id;
              },
            ),
          ),
        );
        yield failureOrNode.fold(
          (failure) {
            if (failure is ServerFailure)
              return ErrorDecisionTreeState(message: failure.failureMessage);
            else if (failure is NoInternetConnectionFailure)
              return ErrorDecisionTreeState(message: failure.failureMessage);
            else
              return ErrorDecisionTreeState(message: 'Erro desconhecido');
          },
          (node) {
            if (node.nodeType.id == 1) {
              return QuestionDecisionTreeState(
                  node: node, idAppointment: teste);
            } else if (node.nodeType.id == 2) {
              return DecisionDecisionTreeState(
                  node: node, idAppointment: teste);
            } else if (node.nodeType.id == 3)
              return ActionDecisionTreeState(
                node: node,
                idAppointment: teste,
              );
            else
              return ErrorDecisionTreeState(message: 'Código inválido');
          },
        );
      }
    } else if (event is GetCurrentNodeDecisionTreeEvent) {
      yield LoadingDecisionTreeState();

      var failureOrNode = await getCurrentNode(
          ParamsCurrentNode(idAppointment: event.idAppointmment));
      yield failureOrNode.fold(
        (failure) {
          if (failure is ServerFailure)
            return ErrorDecisionTreeState(
              message: failure.failureMessage,
              idAppointment: event.idAppointmment,
            );
          else if (failure is NoInternetConnectionFailure)
            return ErrorDecisionTreeState(
              message: failure.failureMessage,
              idAppointment: event.idAppointmment,
            );
          else
            return ErrorDecisionTreeState(
              message: 'Erro desconhecido',
              idAppointment: event.idAppointmment,
            );
        },
        (node) {
          if (node.nodeType.id == 1) {
            return QuestionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointmment,
            );
          } else if (node.nodeType.id == 2) {
            return DecisionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointmment,
            );
          } else if (node.nodeType.id == 3)
            return ActionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointmment,
            );
          else
            return ErrorDecisionTreeState(
              message: 'Código inválido',
              idAppointment: event.idAppointmment,
            );
        },
      );
    } else if (event is GetNextNodeDecisionTreeEvent) {
      yield LoadingDecisionTreeState();

      var failureOrNode = await sendAnswer(ParamsAnswer(answer: event.answer));
      yield failureOrNode.fold(
        (failure) {
          if (failure is ServerFailure)
            return ErrorDecisionTreeState(message: failure.failureMessage);
          else if (failure is NoInternetConnectionFailure)
            return ErrorDecisionTreeState(message: failure.failureMessage);
          else
            return ErrorDecisionTreeState(message: 'Erro desconhecido');
        },
        (node) {
          if (node.nodeType.id == 1) {
            var questionDecisionTreeState = QuestionDecisionTreeState(
              node: node,
              idAppointment: event.answer.medicalAppointmentId,
            );
            return questionDecisionTreeState;
          } else if (node.nodeType.id == 2) {
            return DecisionDecisionTreeState(
              node: node,
              idAppointment: event.answer.medicalAppointmentId,
            );
          } else if (node.nodeType.id == 3)
            return ActionDecisionTreeState(
              node: node,
              idAppointment: event.answer.medicalAppointmentId,
            );
          else
            return ErrorDecisionTreeState(message: 'Código inválido');
        },
      );
    } else if (event is ConfirmDecisionDecisionTreeEvent) {
      yield LoadingDecisionTreeState();

      var failureOrNode = await finishAppointment(ParamsFinishAppointment(
        medicalAppointmentId: event.idAppointment,
        idDecision: event.idDecision,
      ));
      yield failureOrNode.fold(
        (failure) {
          if (failure is ServerFailure)
            return ErrorDecisionTreeState(message: failure.failureMessage);
          else if (failure is NoInternetConnectionFailure)
            return ErrorDecisionTreeState(message: failure.failureMessage);
          else
            return ErrorDecisionTreeState(message: 'Erro desconhecido');
        },
        (success) {
          return AppointmentFinished();
        },
      );
    } else if (event is ConfirmActionDecisionTreeEvent) {
      yield LoadingDecisionTreeState();

      var failureOrNode = await confirmAction(ParamsConfirmAction(
          idAppointment: event.idAppointment, idAction: event.idAction));
      yield failureOrNode.fold(
        (failure) {
          if (failure is ServerFailure)
            return ErrorDecisionTreeState(message: failure.failureMessage);
          else if (failure is NoInternetConnectionFailure)
            return ErrorDecisionTreeState(message: failure.failureMessage);
          else
            return ErrorDecisionTreeState(message: 'Erro desconhecido');
        },
        (node) {
          if (node.nodeType.id == 1) {
            return QuestionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointment,
            );
          } else if (node.nodeType.id == 2) {
            return DecisionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointment,
            );
          } else if (node.nodeType.id == 3)
            return ActionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointment,
            );
          else
            return ErrorDecisionTreeState(message: 'Código inválido');
        },
      );
    } else if (event is GetPreviousNodeDecisionTreeEvent) {
      yield LoadingDecisionTreeState();

      var failureOrNode = await previousQuestion(ParamsPreviousNode(
        idAppointment: event.idAppointment,
        idCurrentNode: event.idNode,
      ));
      yield failureOrNode.fold(
        (failure) {
          if (failure is ServerFailure)
            return ErrorDecisionTreeState(
              message: failure.failureMessage,
              idAppointment: event.idAppointment,
            );
          else if (failure is NoInternetConnectionFailure)
            return ErrorDecisionTreeState(
              message: failure.failureMessage,
              idAppointment: event.idAppointment,
            );
          else
            return ErrorDecisionTreeState(
              message: 'Erro desconhecido',
              idAppointment: event.idAppointment,
            );
        },
        (node) {
          if (node.nodeType.id == 1) {
            return QuestionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointment,
            );
          } else if (node.nodeType.id == 2) {
            return DecisionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointment,
            );
          } else if (node.nodeType.id == 3)
            return ActionDecisionTreeState(
              node: node,
              idAppointment: event.idAppointment,
            );
          else
            return ErrorDecisionTreeState(
              message: 'Código inválido',
              idAppointment: event.idAppointment,
            );
        },
      );
    }
  }
}

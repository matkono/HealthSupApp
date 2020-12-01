import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/answer.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:dartz/dartz.dart';

abstract class DecisionTreeRepository {
  Future<Either<Failure, Node>> startMedicalAppointment();
  Future<Either<Failure, Node>> sendAnswer(Answer answer);
  Future<Either<Failure, Node>> previousQuestion(int idAppointment, int idCurrentNode);
  Future<Either<Failure, Node>> finishAppointment(int idQuestion, bool finished);
  Future<Either<Failure, Node>> getCurrentNode(int idAppointment);
  Future<Either<Failure, Node>> confirmAction(int idAction, int idAppointment);
}
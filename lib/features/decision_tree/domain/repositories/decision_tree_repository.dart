import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/decision_tree/domain/entities/answer.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/decision_tree/domain/entities/node.dart';
import 'package:dartz/dartz.dart';

abstract class DecisionTreeRepository {
  Future<Either<Failure, MedicalAppointment>> startMedicalAppointment(
      int patientId, int diseaseId);
  Future<Either<Failure, Node>> sendAnswer(Answer answer);
  Future<Either<Failure, Node>> previousQuestion(
      int idAppointment, int idCurrentNode);
  Future<Either<Failure, void>> finishAppointment(
      int idAppointment, int idDecision);
  Future<Either<Failure, Node>> getCurrentNode(int idAppointment);
  Future<Either<Failure, Node>> confirmAction(int idAction, int idAppointment);
}

import 'package:cardiompp/core/error/failure.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/node.dart';
import 'package:dartz/dartz.dart';

abstract class DecisionTreeRepository {
  Future<Either<Failure, Node>> startMedicalAppointment();
  Future<Either<Failure, Node>> sendAnswer(Answer answer);
  Future<Either<Failure, Node>> lastQuestion(int idQuestion);
}
import 'package:cardiompp/core/error/exception.dart';
import 'package:cardiompp/core/error/failure.dart';
import 'package:cardiompp/features/decision_tree/data/datasources/local_datasource_impl.dart';
import 'package:cardiompp/features/decision_tree/data/datasources/remote_datasource_impl.dart';
import 'package:cardiompp/features/decision_tree/data/models/answer_model.dart';
import 'package:cardiompp/features/decision_tree/data/models/authenticateApi_model.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/node.dart';
import 'package:cardiompp/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:dartz/dartz.dart';

class DecisionTreeRepositoryImpl implements DecisionTreeRepository {
  var remoteDataSource = new RemoteDataSourceImpl();
  var localDataSource = new LocalDataSourceImpl();
  var tokenKey = 'tokenJWT';
  var tokenTimeKey = 'tokenCurrentTime';
  var loginAPIModel = new AuthenticateApiModel(
    agentName: 'CardiomppApp',
    password: '2e0f011c-a22d-4771-8c50-a9491b96dfea',
  );

  @override
  Future<Either<Failure, Node>> startMedicalAppointment() async {
    try{
      final startNode = await remoteDataSource.getFirstNodeMedicalAppointment();
      return Right(startNode);
    } on ServerException catch(_) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Node>> sendAnswer(Answer answer) async {
    try{
      final fromEntity = AnswerModel.fromEntity(answer);

      final sendNode = await remoteDataSource.setAnswer(fromEntity);
      return Right(sendNode);
    } on ServerException catch(_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Node>> lastQuestion(int idQuestion) async {
    try{
      final lastNode = await remoteDataSource.getLastQuestion(idQuestion);
      return Right(lastNode);
    } on ServerException catch(_) {
      return Left(ServerFailure());
    }
  }
}
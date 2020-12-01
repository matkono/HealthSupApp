import 'package:HealthSup/core/error/exception.dart';
import 'package:HealthSup/core/error/failure.dart';
import 'package:HealthSup/core/usecase/usecase.dart';
import 'package:HealthSup/features/decision_tree/domain/entities/node.dart';
import 'package:HealthSup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:dartz/dartz.dart';

class StartMedicalAppointment extends UseCase<Node, NoParams> {
  final DecisionTreeRepository treeRepository;

  StartMedicalAppointment(
    this.treeRepository,
  );

  @override
  Future<Either<Failure, Node>> call(NoParams params) async {
    try {
      final nodeType = await treeRepository.startMedicalAppointment();
      return nodeType;
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}

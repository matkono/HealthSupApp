import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String failureMessage;

  ServerFailure({
    this.failureMessage = 'Server failure',
  });
  
  @override
  List<Object> get props => [failureMessage];
}
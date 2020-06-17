import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {}

class ServerException extends Exception {
  final String exceptionMessage;

  ServerException({
    this.exceptionMessage = 'Server Exception',
  });
  @override
  List<Object> get props => [exceptionMessage];
}
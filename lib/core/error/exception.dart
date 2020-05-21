import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {}

class ServerException extends Exception {
  final String exceptionMessage = 'Server Exception';
  @override
  List<Object> get props => [exceptionMessage];
}
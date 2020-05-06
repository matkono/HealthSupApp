import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Question extends Equatable{
  final int id;
  final String question;
  final String answer;

  Question({
    @required this.id,
    @required this.question,
    @required this.answer
  });

  @override
  List<Object> get props => null;
}
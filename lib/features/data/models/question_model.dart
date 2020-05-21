import 'package:cardiompp/features/domain/entities/question.dart';
import 'package:meta/meta.dart';

class QuestionModel extends Question {

  QuestionModel({
    @required int id,
    @required String question,
    @required String answer,
  }) : super(id: id, question: question, answer: answer);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      question: json['title'],
      answer: json['subtitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': question,
      'subtitle': answer,
    };
  }
}
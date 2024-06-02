import 'package:app/domain/quiz.dart';

class Question {
  final Quiz quiz;
  final int id;
  final String text;
  final String answer;

  Question(
      {required this.text,
      required this.answer,
      required this.id,
      required this.quiz});

  Map<String, dynamic> toMap() {
    return {'text': text, 'answer': answer, 'quiz': quiz.id};
  }

  String getText() {
    return text;
  }

  String getAnswer() {
    return answer;
  }
}

import 'dart:ui';
import 'package:app/databases/QuizDB.dart';
import 'package:app/domain/question.dart';
import 'package:uuid/uuid.dart';

class Quiz {
  late int id;
  String name;
  String description;
  Color color;
  Map<String, Question> questions = {};

  Quiz({
    required this.name,
    required this.description,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'color': color.toHex()};
  }

  Question? getQuestion(int questionID) {
    return questions[questionID];
  }

  void addQuestion(Question question) async {
    await QuizzesDatabase().insertQuestion(question);
    questions[question.id] = question;
  }

  void updateQuestion(String text, String answer, Question question) {
    QuizzesDatabase().updateQuestion(text, answer, question);
    question.text = text;
    question.answer = answer;
    questions[question.id] = question;
  }

  void deleteQuestion(Question question) async {
    await QuizzesDatabase().deleteQuestion(question);
    questions.remove(question.id);
  }
}

extension ColorExtension on Color {
  String toHex() {
    return 'FF${value.toRadixString(16).toUpperCase().substring(1)}';
  }
}

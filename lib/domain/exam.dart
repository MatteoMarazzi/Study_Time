import 'dart:ui';
import 'package:app/databases/QuizDB.dart';
import 'package:app/domain/quiz.dart';
import 'package:uuid/uuid.dart';

class Exam {
  late String id;
  final String name;
  final String description;
  final Map<String, Quiz> quizzesMap = {};
  final List<Quiz> quizzesList = [];

  Exam({required this.name, required this.description}) {
    id = const Uuid().v4();
  }

  Future addQuiz({required name, required description, required color}) async {
    Quiz newQuiz = Quiz(name: name, description: description, color: color);
    if (quizzesMap.containsKey(newQuiz.id)) {
      throw Exception('Quiz with ID ${newQuiz.id} already exists');
    }
    quizzesMap[newQuiz.id] = newQuiz;
    quizzesList.add(newQuiz);
    await QuizzesDatabase().insertQuiz(newQuiz);
  }

  void removeQuiz(String id) {
    final quiz = quizzesMap.remove(id);
    if (quiz != null) {
      quizzesList.remove(quiz);
    }
  }

  Future updateQuiz(
      String name, String description, Color color, Quiz quiz) async {
    await QuizzesDatabase().updateQuiz(name, description, color, quiz);
    quizzesMap[quiz.id]!.name = name;
    quizzesMap[quiz.id]!.description = description;
    quizzesMap[quiz.id]!.color = color;
  }

  Future deleteQuiz(Quiz quiz) async {
    await QuizzesDatabase().deleteQuiz(quiz);
    quizzesMap.remove(quiz.id);
    quizzesList.remove(quiz);
  }

  Quiz? getQuiz(int index) {
    if (index < 0 || index >= quizzesList.length) {
      return null;
    }
    return quizzesList[index];
  }

  int countQuizzes() {
    return quizzesMap.length;
  }
}

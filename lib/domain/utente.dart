import 'dart:ui';
import 'package:app/databases/QuizDB.dart';
import 'package:app/domain/quiz.dart';

class Utente {
  static final Utente _instance = Utente._internal();
  final Map<int, Quiz> quizzesMap = {};
  final List<Quiz> quizzesList = [];

  factory Utente() {
    return _instance;
  }

  Utente._internal();

  Future mountDatabase() async {
    await QuizzesDatabase().getAllQuizzes(this);
  }

  //aggiunta di un nuovo quiz non presente nel database DA FARE
  Future addQuiz({required name, required description, required color}) async {}

  mountQuiz(quiz) {
    quizzesMap[quiz.id] = quiz;
    quizzesList.add(quiz);
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

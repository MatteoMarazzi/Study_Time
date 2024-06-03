import 'dart:ui';
import 'package:app/databases/QuizDB.dart';
import 'package:app/domain/question.dart';

class Quiz {
  final int id;
  final String name;
  final String description;
  final Color color;
  Map<int, Question> questionsMap = {};
  final List<Question> questionsList = [];

  Quiz({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'color': color.toHex()};
  }

  Future mountDatabase() async {
    questionsList.addAll(await QuizzesDatabase().getAllQuestions(this));
    questionsMap = {for (var question in questionsList) question.id: question};
  }

  Question? getQuestion(int index) {
    if (index < 0 || index >= questionsList.length) {
      return null;
    }
    return questionsList[index];
  }

  void addQuestion({required text, required answer}) async {
    Question temp = Question(id: 0, text: text, answer: answer, quiz: this);
    int genereatedId = await QuizzesDatabase().insertQuestion(temp);
    Question newQuestion =
        Question(id: genereatedId, text: text, answer: answer, quiz: this);
    questionsList.add(newQuestion);
    questionsMap[newQuestion.id] = newQuestion;
  }

  void updateQuestion(String newText, String newAnswer, Question question) {
    QuizzesDatabase().updateQuestion(newText, newAnswer, question);
    Question updatedQuestion =
        Question(text: newText, answer: newAnswer, id: question.id, quiz: this);
    questionsMap[question.id] = updatedQuestion;
    for (int i = 0; i < questionsList.length; i++) {
      if (questionsList[i].id == question.id) {
        questionsList[i] = updatedQuestion;
        break;
      }
    }
  }

  void deleteQuestion(Question question) async {
    await QuizzesDatabase().deleteQuestion(question);
    questionsMap.remove(question.id);
    questionsList.remove(question);
  }
}

extension ColorExtension on Color {
  String toHex() {
    return 'FF${value.toRadixString(16).toUpperCase().substring(1)}';
  }
}

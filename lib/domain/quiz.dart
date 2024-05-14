import 'dart:ui';

import 'package:app/domain/question.dart';

class Quiz {
  int? id; //vorrei non metterlo nullable
  String name;
  String description;
  Color color;
  Map<int, Question> questions = {};

  Quiz(
      {this.id,
      required this.name,
      required this.description,
      required this.color});

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description};
  }

  Question? getQuestion(int questionID) {
    return questions[questionID];
  }

  void addQuestions(Map<int, Question> questions) {
    this.questions.addAll(questions);
  }
}

extension ColorExtension on Color {
  String toHex() {
    return 'FF${value.toRadixString(16).toUpperCase().substring(1)}';
  }
}

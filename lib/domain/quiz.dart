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
    return {'name': name, 'description': description, 'color': color.toHex()};
  }

  Question? getQuestion(int questionID) {
    return questions[questionID];
  }

  void addQuestion(Question question) {
    questions[question.id] = question;
  }
}

extension ColorExtension on Color {
  String toHex() {
    return 'FF${value.toRadixString(16).toUpperCase().substring(1)}';
  }
}

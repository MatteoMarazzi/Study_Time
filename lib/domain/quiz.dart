import 'dart:ui';
import 'package:app/domain/question.dart';
import 'package:uuid/uuid.dart';

class Quiz {
  late String id;
  String name;
  String description;
  Color color;
  Map<String, Question> questions = {};

  Quiz({required this.name, required this.description, required this.color}) {
    id = const Uuid().v4();
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'color': color.toHex()};
  }

  String getName() {
    return name;
  }

  String getDescription() {
    return description;
  }

  Color getColor() {
    return color;
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

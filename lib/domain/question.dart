import 'package:app/domain/quiz.dart';

enum Difficulty { facile, difficile, nonValutata }

int difficultyToInt(Difficulty difficulty) {
  return difficulty.index;
}

Difficulty intToDifficulty(int value) {
  return Difficulty.values[value];
}

class Question {
  final Quiz quiz;
  final int id;
  final String text;
  final String answer;
  Difficulty difficulty;

  Question(
      {required this.text,
      required this.answer,
      required this.id,
      required this.quiz,
      this.difficulty = Difficulty.nonValutata});

  Map<String, dynamic> toMap() {
    return {'text': text, 'answer': answer, 'quiz': quiz.id};
  }

  String difficultyString() {
    switch (difficulty) {
      case Difficulty.facile:
        return 'Facile';
      case Difficulty.difficile:
        return 'Difficile';
      case Difficulty.nonValutata:
        return 'Nuova';
      default:
        return '';
    }
  }
}

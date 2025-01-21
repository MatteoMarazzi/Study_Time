import 'package:app/domain/quiz.dart';

enum Difficulty { facile, difficile, nonValutata }

int difficultyToInt(Difficulty difficulty) {
  return difficulty.index;
}

Difficulty intToDifficulty(int value) {
  return Difficulty.values[value];
}

class Flashcard {
  final Quiz quiz;
  final int id;
  String question;
  String answer;
  Difficulty difficulty;

  Flashcard(
      {required this.question,
      required this.answer,
      required this.id,
      required this.quiz,
      this.difficulty = Difficulty.nonValutata});

  Map<String, dynamic> toMap() {
    return {'question': question, 'answer': answer, 'quiz': quiz.id};
  }

  String difficultyString() {
    switch (difficulty) {
      case Difficulty.facile:
        return 'Facile';
      case Difficulty.difficile:
        return 'Difficile';
      case Difficulty.nonValutata:
        return 'Nuova';
    }
  }
}

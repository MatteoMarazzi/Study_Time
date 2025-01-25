import 'dart:ui';
import 'package:app/databases/QuizDB.dart';
import 'package:app/domain/flashcard.dart';

class Quiz {
  final int id;
  String name;
  String description;
  Color color;
  Map<int, Flashcard> flashcardsMap = {};
  final List<Flashcard> flashcardsList = [];

  Quiz({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'color': rgbToHex(color)};
  }

  Future mountDatabase() async {
    flashcardsList.addAll(await QuizzesDatabase().getAllFlashcards(this));
    flashcardsMap = {
      for (var question in flashcardsList) question.id: question
    };
  }

  Flashcard? getFlashcard(int index) {
    if (index < 0 || index >= flashcardsList.length) {
      return null;
    }
    return flashcardsList[index];
  }

  Future addFlashcard({required question, required answer}) async {
    Flashcard temp =
        Flashcard(id: 0, question: question, answer: answer, quiz: this);
    int genereatedId = await QuizzesDatabase().insertFlashcard(temp);
    Flashcard newFlashcard = Flashcard(
        id: genereatedId, question: question, answer: answer, quiz: this);
    print("passo di qui?");
    flashcardsList.add(newFlashcard);
    flashcardsMap[newFlashcard.id] = newFlashcard;
  }

  Future updateFlashcard(
      String newQuestion, String newAnswer, Flashcard flashcard) async {
    QuizzesDatabase().updateFlashcard(newQuestion, newAnswer, flashcard);
    flashcard.question = newQuestion;
    flashcard.answer = newAnswer;
  }

  Future<void> updateDifficulty(
      Flashcard flashcard, Difficulty newDifficulty) async {
    await QuizzesDatabase().updateFlashcardDifficulty(
        flashcard.id, difficultyToInt(newDifficulty));
    flashcard.difficulty = newDifficulty;
  }

  Future deleteFlashcard(Flashcard flashcard) async {
    await QuizzesDatabase().deleteFlashcard(flashcard);
    flashcardsMap.remove(flashcard.id);
    flashcardsList.remove(flashcard);
  }
}

String rgbToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

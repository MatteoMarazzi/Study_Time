import 'package:app/domain/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../domain/quiz.dart';

Database? _database;
//List quizzesDataList = [];

class QuizzesDatabase {
  Future get database async {
    _database ??= await _initializeDB('QuizDB.db');
    return _database;
  }

  Future _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE quizzes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT,
      color TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE flashcards(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      quiz INTEGER NOT NULL,
      question TEXT NOT NULL,
      answer TEXT,
      difficulty INTEGER NOT NULL DEFAULT 2,
      FOREIGN KEY (quiz) REFERENCES quizzes(id)
    )
  ''');
  }

  Future<Iterable<Quiz>> getAllQuizzes() async {
    final db = await database;
    final List<Map<String, dynamic>> quizMaps = await db.query('quizzes');
    final Iterable<Quiz> quizList = quizMaps.map((quizMap) {
      return Quiz(
        id: quizMap['id'],
        name: quizMap['name'],
        description: quizMap['description'],
        color: Color(int.parse(quizMap['color'], radix: 16)),
      );
    });
    return quizList;
  }

  Future<Iterable<Flashcard>> getAllFlashcards(Quiz quiz) async {
    final db = await database;
    final List<Map<String, dynamic>> flashcardsMaps = await db.query(
      'flashcards',
      where: 'quiz = ?',
      whereArgs: [quiz.id],
    );
    final Iterable<Flashcard> flashcardsList =
        flashcardsMaps.map((flashcardMap) {
      return Flashcard(
          id: flashcardMap['id'],
          question: flashcardMap['question'],
          answer: flashcardMap['answer'],
          difficulty: intToDifficulty(flashcardMap['difficulty']),
          quiz: quiz);
    });
    return flashcardsList;
  }

  Future<int> insertQuiz(Quiz quiz) async {
    final db = await database;
    final id = await db.insert("quizzes", quiz.toMap());
    return await id;
  }

  Future<int> updateQuiz(
      String name, String description, Color selectedColor, Quiz quiz) async {
    final db = await database;
    int dbupdateid = await db.rawUpdate(
        'UPDATE quizzes SET name = ?, description = ?,color = ? WHERE id = ?',
        [name, description, rgbToHex(selectedColor), quiz.id]);
    return dbupdateid;
  }

  Future deleteQuiz(Quiz quiz) async {
    final db = await database;
    await db!.delete("quizzes", where: 'id=?', whereArgs: [quiz.id]);
    //QuestionsDatabase().deleteAllQuestionsFromQuiz(quiz);
    return 'succesfully deleted';
  }

  Future<int> updateFlashcard(
      String question, String answer, Flashcard flashcard) async {
    final db = await database;
    int dbupdateid = await db.rawUpdate(
        'UPDATE flashcards SET question = ?, answer = ? WHERE id = ?',
        [question, answer, flashcard.id]);
    return dbupdateid;
  }

  Future<int> updateFlashcardDifficulty(int flashcardId, int difficulty) async {
    final db = await database;
    int dbupdateid = await db.rawUpdate(
        'UPDATE flashcards SET difficulty = ? WHERE id = ?',
        [difficulty, flashcardId]);
    return dbupdateid;
  }

  Future insertFlashcard(Flashcard flashcard) async {
    final db = await database;
    final id = db.insert("flashcards", flashcard.toMap());
    return await id;
  }

  Future deleteFlashcard(Flashcard? flashcard) async {
    final db = await database;
    await db!.delete("flashcards", where: 'id=?', whereArgs: [flashcard!.id]);
  }

  Future deleteAllFlashcardsFromQuiz(Quiz quiz) async {
    final db = await database;
    await db.delete('flashcards', where: 'quiz = ?', whereArgs: [quiz.id]);
  }
}

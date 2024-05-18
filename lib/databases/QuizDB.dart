import 'package:app/databases/questionsDB.dart';
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
      id INTEGER PRIMARY KEY,
      name TEXT,
      description TEXT,
      color TEXT
    )
    ''');
  }

  Future<int> insertQuiz(Quiz quiz) async {
    final db = await database;
    return await db.insert("quizzes", quiz.toMap());
  }

  Future getAllQuizzes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quizzes');
    List<Quiz> quizzesList = List.generate(maps.length, (i) {
      return Quiz(
          name: maps[i]['name'],
          description: maps[i]['description'],
          color: Color(int.parse('${maps[i]['color']}', radix: 16)));
    });
  }

  Future<int> updateQuiz(
      String name, String description, Color selectedColor, Quiz quiz) async {
    final db = await database;
    int dbupdateid = await db.rawUpdate(
        'UPDATE quizzes SET name = ?, description = ?,color = ? WHERE id = ?',
        [name, description, selectedColor.toHex(), quiz.id]);
    return dbupdateid;
  }

  Future deleteQuiz(Quiz quiz) async {
    final db = await database;
    await db!.delete("quizzes", where: 'id=?', whereArgs: [quiz.id]);
    QuestionsDatabase().deleteAllQuestionsFromQuiz(quiz);
    return 'succesfully deleted';
  }
}

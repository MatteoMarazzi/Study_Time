import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../objects/quiz.dart';

Database? _database;
List QuizzesDataList = [];

class LocalDataBase {
  Future get database async {
    if (_database == null) _database = await _initializeDB('QuizDB.db');
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
    QuizzesDataList = List.generate(maps.length, (i) {
      return Quiz(
          id: maps[i]['id'],
          name: maps[i]['name'],
          description: maps[i]['description'],
          color: Color(
              int.parse('FF${maps[i]['color'].substring(1)}', radix: 16)));
    });
  }

  Future updateData({Name, id}) async {
    final db = await database;
    int dbupdateid = await db
        .rawUpdate('UPDATE LocalData SET name= ? WHERE id=?', [Name, id]);
    return dbupdateid;
  }

  Future deleteData({id}) async {
    final db = await database;
    await db!.delete("LocalData", where: 'id=?', whereArgs: [id]);
    return 'succesfully deleted';
  }
}

import 'package:app/databases/questionsDB.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;

class SessionsDatabase {
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
    CREATE TABLE sessions(
      id INTEGER PRIMARY KEY,
      name TEXT,
      minuti_studio INTEGER,
      minuti_pausa INTEGER,
      ripetizioni INTEGER
    )
    ''');
  }

  Future getSessions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quizzes');
    List.generate(maps.length, (i) {});
  }
}

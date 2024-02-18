import 'package:app/objects/question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;
List QuestionsDataList = [];

class QuestionsDatabase {
  Future get database async {
    if (_database == null) _database = await _initializeDB('QuestionsDB.db');
    return _database;
  }

  Future _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE questions(
      idQuiz INTEGER PRIMARY KEY,
      text TEXT,
      FOREIGN KEY (IDQuiz) REFERENCES quizzes(id)
    )
    ''');
  }

  Future<int> insertQuestion(Question question) async {
    final db = await database;
    return await db.insert("questions", question.toMap());
  }

  Future getAllQuestions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('questions');
    QuestionsDataList = List.generate(maps.length, (i) {
      return Question(id: maps[i]['id'], text: maps[i]['text']);
    });
  }

  Future<int> updateQuestion(String text, Question question) async {
    final db = await database;
    int dbupdateid = await db.rawUpdate(
        'UPDATE quizzes SET text = ? WHERE id = ?', [text, question.id]);
    return dbupdateid;
  }

  Future deleteQuestion(Question question) async {
    final db = await database;
    await db!.delete("quizzes", where: 'id=?', whereArgs: [question.id]);
    return 'succesfully deleted';
  }
}

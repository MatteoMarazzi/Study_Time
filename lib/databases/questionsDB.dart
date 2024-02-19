import 'package:app/objects/question.dart';
import 'package:app/objects/quiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;
Map<int?, List<Question>> quiz2Questions = {};

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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idQuiz INTEGER,
      text TEXT,
      answer TEXT,
      FOREIGN KEY (idQuiz) REFERENCES quizzes(id)
    )
    ''');
  }

  Future insertQuestion(Question question) async {
    final db = await database;
    await db.insert("questions", question.toMap());
  }

  Future getAllQuestions(Quiz quiz) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'questions',
      where: 'idQuiz = ?',
      whereArgs: [quiz.id],
    );
    List<Question> questions = [];
    for (Map<String, dynamic> map in maps) {
      questions
          .add(Question(idQuiz: quiz.id, id: map['id'], text: map['text']));
    }
    quiz2Questions[quiz.id] ??= [];
    quiz2Questions[quiz.id]!.addAll(questions);
  }

  Future<int> updateQuestion(String text, Question question) async {
    final db = await database;
    int dbupdateid = await db.rawUpdate(
        'UPDATE quizzes SET text = ? WHERE id = ?', [text, question.idQuiz]);
    return dbupdateid;
  }

  Future deleteQuestion(Question question) async {
    final db = await database;
    await db!.delete("quizzes", where: 'id=?', whereArgs: [question.idQuiz]);
  }

  Future deleteAllQuestionsFromQuiz(Quiz quiz) async {
    final db = await database;
    await db.delete('questions', where: 'idQuiz = ?', whereArgs: [quiz.id]);
  }
}

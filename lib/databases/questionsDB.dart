import 'package:app/domain/question.dart';
import 'package:app/domain/quiz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;
//Map<Quiz, List<Question>> quiz2Questions = {};

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
      id INTEGER PRIMARY KEY,
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

  void getAllQuestions(Quiz quiz) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'questions',
      where: 'idQuiz = ?',
      whereArgs: [quiz.id],
    );
    List<Question> questions = maps
        .map((map) => Question(
              id: map['id'],
              text: map['text'],
              answer: map['answer'],
            ))
        .toList();
    for (Question question in questions) {
      quiz.addQuestion(question);
    }
  }

  Future<int> updateQuestion(
      String text, String answer, Question question) async {
    final db = await database;
    int dbupdateid = await db.rawUpdate(
        'UPDATE questions SET text = ?, answer = ? WHERE id = ?',
        [text, answer, question.id]);
    return dbupdateid;
  }

  Future deleteQuestion(Question? question) async {
    final db = await database;
    await db!.delete("questions", where: 'id=?', whereArgs: [question!.id]);
  }

  Future deleteAllQuestionsFromQuiz(Quiz quiz) async {
    final db = await database;
    await db.delete('questions', where: 'idQuiz = ?', whereArgs: [quiz.id]);
  }
}

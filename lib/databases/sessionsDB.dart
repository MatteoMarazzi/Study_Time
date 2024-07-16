import 'package:app/domain/session.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;

class SessionsDatabase {
  Future get database async {
    _database ??= await _initializeDB('sessionsDB.db');
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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      minuti_studio INTEGER,
      minuti_pausa INTEGER,
      ripetizioni INTEGER
    )
    ''');
    List<Session> predefinedSessions = [
      Session(
          id: 1,
          title: 'standard',
          minutiStudio: 25,
          minutiPausa: 4,
          ripetizioni: 4),
      Session(
          id: 2,
          title: 'personalizzata1',
          minutiStudio: 0,
          minutiPausa: 0,
          ripetizioni: 0),
      Session(
          id: 3,
          title: 'personalizzata2',
          minutiStudio: 0,
          minutiPausa: 0,
          ripetizioni: 0),
    ];

    for (var session in predefinedSessions) {
      await db.insert('sessions', session.toMap());
    }
  }

  Future<Session> getSession(String sessionTitle) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sessions',
      where: 'title = ?',
      whereArgs: [sessionTitle],
    );

    if (maps.isNotEmpty) {
      return Session.fromMap(maps.first);
    } else {
      throw Exception('No session found with title $sessionTitle');
    }
  }

  Future<int> updateSession(Session session) async {
    final db = await database;
    int dbupdateid = await db.rawUpdate(
        'UPDATE sessions SET title = ?, minuti_studio = ?, minuti_pausa = ?, ripetizioni = ? WHERE id = ?',
        [
          session.title,
          session.minutiStudio,
          session.minutiPausa,
          session.ripetizioni,
          session.id
        ]);
    return dbupdateid;
  }
}

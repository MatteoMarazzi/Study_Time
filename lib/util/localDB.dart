import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;
List WholeDataList = [];

class LocalDataBase {
  Future get database async {
    if (_database == null) _database = await _initializeDB('Local.db');
    return _database;
  }

  Future _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE LocalData(id INTEGER PRIMARY KEY,
      Name TEXT NOT NULL,
      Description TEXT,
      red INTEGER,
      green INTEGER,
      blue INTEGER
      )
      ''');
  }

  Future addDataLocally({Name, Description, red, green, blue}) async {
    final db = await database;
    await db.insert("LocalData", {
      "Name": Name,
      "Description": Description,
      "red": red,
      "green": green,
      "blue": blue
    });
    return 'added';
  }

  Future readAllData() async {
    final db = await database;
    final alldata = await db!.query("LocalData");
    WholeDataList = alldata;
    print(WholeDataList);
    return 'succesfully read';
  }

  Future updateData({Name, id}) async {
    final db = await database;
    int dbupdateid = await db
        .rawUpdate('UPDATE LocalData SET Name= ? WHERE id=?', [Name, id]);
    return dbupdateid;
  }

  Future deleteData({id}) async {
    final db = await database;
    await db!.delete("LocalData", where: 'id=?', whereArgs: [id]);
    return 'succesfully deleted';
  }
}

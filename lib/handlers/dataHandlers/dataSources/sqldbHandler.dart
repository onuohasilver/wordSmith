import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'db';
  static final _dbVersion = 1;
  static final levelTable = 'LevelProgressTable';
  static final userTable = 'UserTable';
  static final score = 'Score';
  static final levelID = 'LevelID';

  static final stars = 'Stars';
  static final columnID = 'id';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      '''()
      CREATE TABLE $levelTable (
        $columnID INTEGER PRIMARY KEY,
        $stars TEXT NOT NULL,
        $score INTEGER NOT NULL,
        $levelID INTEGER NOT NULL
      )
      ''',
    );
  }

  Future<int> insert(
      {@required Map<String, dynamic> row, @required tableName}) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int> update(
      {@required Map<String, dynamic> row, @required String tableName}) async {
    Database db = await instance.database;
    assert(row.containsKey('LevelID'));
    int id = row['LevelID'];

    return await db
        .update(tableName, row, where: '$levelID = ?', whereArgs: [id]);
  }

  Future<int> delete({@required int id, @required String tableName}) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnID = ?', whereArgs: [id]);
  }
}

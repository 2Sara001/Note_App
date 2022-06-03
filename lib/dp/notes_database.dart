import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import '../model/note.dart';

class NoteDatabase {
  static Database? _dbHelper;

  Future<Database?> get db async {
    if (_dbHelper == null) {
      _dbHelper = await intialDb();
      return _dbHelper;
    } else {
      return _dbHelper;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'lapdb.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE notes (
          id INTEGER PRIMARY KEY,
          title TEXT,
          description TEXT,
          color INTEGER
           )''');
  }

  getNotes(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertNote(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateNote(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteNote(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}

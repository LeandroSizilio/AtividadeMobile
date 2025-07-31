import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE fichas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        str INTEGER,
        dex INTEGER,
        con INTEGER,
        inteli INTEGER,
        wis INTEGER,
        hp INTEGER,
        mana INTEGER,
        nome TEXT NOT NULL,
        race TEXT NOT NULL
      )
    ''');
  }

  // Future<void> verificarBanco() async {
  //   final db = await database;
  //   final resultado = await db.rawQuery(
  //     "SELECT name FROM sqlite_master WHERE type='table'"
  //   );

  //   print('Tabelas no banco:');
  //   for (var row in resultado) {
  //     print(row['name']);
  //   }
  // }
}



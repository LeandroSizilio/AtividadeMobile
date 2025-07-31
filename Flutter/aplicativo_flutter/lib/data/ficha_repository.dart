import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'models/ficha.dart';

class FichaRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  // Método para inserir uma nova ficha (Create)
  Future<int> insert(Ficha ficha) async {
    final db = await _databaseHelper.database;
    return await db.insert('fichas', ficha.toMap());
  }

  // Método para buscar todas as fichas (Read)
  Future<List<Ficha>> getAllFichas() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('fichas');

    return List.generate(maps.length, (i) {
      return Ficha.fromMap(maps[i]);
    });
  }

  // Método para buscar uma ficha por ID (Read)
  Future<Ficha?> getFichaById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'fichas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Ficha.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Método para atualizar uma ficha (Update)
  Future<int> update(Ficha ficha) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'fichas',
      ficha.toMap(),
      where: 'id = ?',
      whereArgs: [ficha.id],
    );
  }

  // Método para deletar uma ficha (Delete)
  Future<int> delete(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      'fichas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
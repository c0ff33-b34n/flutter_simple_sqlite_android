import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'film_model.dart';

class DataBase {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'films.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE films(id INTEGER PRIMARY KEY, title TEXT NOT NULL, director TEXT NOT NULL, releaseYear INTEGER NOT NULL)",
        );
      },
    );
  }

  Future<int> addFilms(List<Film> films) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var film in films) {
      result = await db.insert('films', film.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return result;
  }

  Future<List<Film>> getAllFilms() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('films');
    return queryResult.map((e) => Film.fromMap(e)).toList();
  }

  Future<void> deleteFilm(int id) async {
    final db = await initializeDB();
    await db.delete(
      'films',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

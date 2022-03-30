import 'package:note/models/noteModel.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _name = "Notes.db";
  static const _version = 1;

  Database? database;
  static const tableName = 'notes';

  initDatabase() async {
    database = await openDatabase(_name, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $tableName (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    title TEXT,
                    content TEXT
                    )''');
    });
  }

  Future<int> insertNote(NoteModel note) async {
    return await database!.insert(tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateNote(NoteModel note) async {
    return await database!.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    await initDatabase();
    return await database!.query(tableName);
  }

  Future<Map<String, dynamic>?> getNotes(int id) async {
    var result =
        await database!.query(tableName, where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> deleteNote(int id) async {
    return await database!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  closeDatabase() async {
    await database!.close();
  }
}

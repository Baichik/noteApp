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
    await initDatabase();
    return await database!.insert(tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateNote(NoteModel note) async {
    await initDatabase();
    return await database!.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<List<NoteModel>> getAllNotes() async {
    await initDatabase();
    final data = await database!.query(tableName);
    if (data.isEmpty) return [];
    return data.map(NoteModel.fromMap).toList();
  }

  Future<NoteModel?> getNotes(int id) async {
    await initDatabase();
    var result =
        await database!.query(tableName, where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return NoteModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteNote(int id) async {
    await initDatabase();
    return await database!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  closeDatabase() async {
    await initDatabase();
    await database!.close();
  }
}

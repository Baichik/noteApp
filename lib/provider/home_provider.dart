import 'package:flutter/cupertino.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/models/noteModel.dart';

class HomeProvider extends ChangeNotifier {
  final DBHelper dbHelper;
  HomeProvider(this.dbHelper) {
    dbHelper.initDatabase();
  }

  List<Map<String, dynamic>> _notes = [{}];

  List<Map<String, dynamic>> get notes => _notes;

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value){
    if(value == loading) return;
    _loading = value;
    notifyListeners();
  }

  set notes(List<Map<String, dynamic>> value) {
    if (value == notes && value.isNotEmpty) return;
    _notes = value;
    loading = false;
    notifyListeners();
  }

  Future<void> getNotes() async {
    try {
      loading = true;
      List<Map> notesList = await dbHelper.getAllNotes();
      notes = List<Map<String, dynamic>>.from(notesList);
    } catch (e){
      print("Error: $e");
    }
  }

  Future<void> deleteNote(int id) async {
    await dbHelper.deleteNote(id);
    await getNotes();
  }

  
  Future<void> updateNote(NoteModel note) async {
    await dbHelper.updateNote(note);
    await getNotes();
  }

    Future<void> insertNote(NoteModel note) async {
    await dbHelper.insertNote(note);
    await getNotes();
  }

  @override
  void dispose() {
    dbHelper.closeDatabase();
    super.dispose();
  }
}

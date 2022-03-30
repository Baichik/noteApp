import 'package:flutter/material.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/models/noteModel.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _insertNote(NoteModel note) async {
    DBHelper db = DBHelper();
    await db.initDatabase();
    await db.insertNote(note);
    await db.closeDatabase();
  }

  void onTapChek() async {
    if (_titleController.text.isEmpty) {
      if (_descriptionController.text.isEmpty) {
        Navigator.of(context).pop();
        return;
      }
    }
    NoteModel newNote = NoteModel(
        _titleController.text.trim(), _descriptionController.text.trim());
    try {
      await _insertNote(newNote);
    } catch (e) {
      print(e);
    } finally {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: onTapChek, icon: const Icon(Icons.check)),
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                    counter: null,
                    counterText: "",
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                  maxLength: 31,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    color: Colors.black,
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Content',
                    hintStyle: TextStyle(
                      fontSize: 19,
                      height: 1.5,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 19,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/models/noteModel.dart';

class UpdateScreen extends StatefulWidget {
  final int? id;
  const UpdateScreen({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DBHelper db = DBHelper();

  Future<void> updateNote(NoteModel note) async {
    await db.initDatabase();
    await db.updateNote(note);
    await db.closeDatabase();
  }

  Future<Map<String, dynamic>> getNote(int id) async {
    await db.initDatabase();
    Map<String, dynamic> note = await db.getNotes(id);
    final noteData = await NoteModel.fromMap(note);
    _titleController.text = noteData.title!;
    _descriptionController.text = noteData.content!;
    return note;
  }

  void onTapChek() async {
    NoteModel newNote = NoteModel(
        _titleController.text, _descriptionController.text,
        id: widget.id);
    try {
      await updateNote(newNote);
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
        IconButton(
            onPressed: () {
              onTapChek();
            },
            icon: const Icon(Icons.check)),
      ]),
      body: FutureBuilder(
          future: getNote(widget.id!),
          builder: (context, noteItems) {
            if (noteItems.hasData) {
              return body();
            } else if (noteItems.hasError) {
              return const Center(child: Text('Error reading database'));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget body() {
    return Padding(
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
          ),
          TextField(
            controller: _descriptionController,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            decoration: null,
            style: const TextStyle(
              fontSize: 19,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

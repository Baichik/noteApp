import 'package:flutter/material.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/models/noteModel.dart';
import 'package:note/provider/home_provider.dart';
import 'package:note/screens/home.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void onTapChek() async {
    final homeProvider = context.read<HomeProvider>();
    if (_titleController.text.isEmpty) {
      if (_descriptionController.text.isEmpty) {
        Navigator.of(context).pop();
        return;
      }
    }
    final NoteModel note = NoteModel(
        _titleController.text.trim(), _descriptionController.text.trim());
    try {
      homeProvider.insertNote(note);
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
                  decoration: null,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/blocs/home_bloc.dart';
import 'package:note/models/noteModel.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void onTapChek() async {
    if (_titleController.text.isEmpty) {
      if (_descriptionController.text.isEmpty) {
        return;
      }
    }
    NoteModel newNote = NoteModel(
        _titleController.text.trim(), _descriptionController.text.trim());
    BlocProvider.of<HomeBloc>(context).add(AddHomeEvent(newNote));
    Navigator.of(context).pop();
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

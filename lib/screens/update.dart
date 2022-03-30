import 'package:flutter/material.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/models/noteModel.dart';
import 'package:note/provider/home_provider.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  final Map myMap;
  const UpdateScreen({Key? key, required this.myMap}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.myMap['title'];
    _descriptionController.text = widget.myMap['content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final int id = widget.myMap['id'];
              final NoteModel note = NoteModel(
                _titleController.text,
                _descriptionController.text,
                id: id,
              );
              homeProvider.updateNote(note);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: body(),
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

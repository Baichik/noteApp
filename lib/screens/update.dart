import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/blocs/home_bloc.dart';
import 'package:note/models/noteModel.dart';

class UpdateScreen extends StatefulWidget {
  final NoteModel noteModel;
  const UpdateScreen({Key? key, required this.noteModel}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = BlocProvider.of(context);
    _titleController.text = widget.noteModel.title ?? "";
    _descriptionController.text = widget.noteModel.content ?? "";
    super.initState();
  }

  void onTapChek() async {
    NoteModel newNote = NoteModel(
      _titleController.text,
      _descriptionController.text,
      id: widget.noteModel.id,
    );
    _homeBloc.add(UpdateHomeEvent(newNote));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: onTapChek, icon: const Icon(Icons.check)),
      ]),
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

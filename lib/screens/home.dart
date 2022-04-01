import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/blocs/home_bloc.dart';
import 'package:note/models/noteModel.dart';
import 'package:note/screens/addNote.dart';
import 'package:note/screens/update.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: _builder,
      ),
    );
  }

  Widget body(List<NoteModel> list) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text(
                    list[index].title ?? '',
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 30),
                    child: Text(
                      list[index].content ?? '',
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onTap: () => _updateNote(context, list[index]),
                  onLongPress: () => _showDialog(context, list[index]),
                ),
              ),
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 25, bottom: 35),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const AddNoteScreen()))
                .then((value) => setState(() {}));
          },
          child: const Icon(Icons.add),
        ),
      )
    ]);
  }

  Widget _builder(BuildContext context, HomeState state) {
    if (state is LoadingHomeState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is LoadedHomeState) {
      return body(state.list);
    } else if (state is ErrorHomeState) {
      return Center(
        child: Text(state.errorText),
      );
    }
    return Container();
  }

  void _updateNote(BuildContext context, NoteModel model) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UpdateScreen(noteModel: model)));
  }

  void _deleteNote(BuildContext context, NoteModel model) {
    _homeBloc.add(DeleteHomeEvent(model));
    Navigator.of(context).pop();
  }

  void _showDialog(BuildContext context, NoteModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete this note?'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => _deleteNote(context, model),
            )
          ],
        );
      },
    );
  }
}

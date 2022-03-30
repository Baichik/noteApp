import 'package:flutter/material.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/screens/addNote.dart';
import 'package:note/screens/update.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper db = DBHelper();

  Future<List<Map<String, dynamic>>> getNotes() async {
    try {
      await db.initDatabase();
      List<Map> notesList = await db.getAllNotes();
      await db.closeDatabase();
      List<Map<String, dynamic>> notes =
          List<Map<String, dynamic>>.from(notesList);
      return notes;
    } catch (e) {
      print(e);
      return [{}];
    }
  }

  Future<void> deleteNote(int id) async {
    await db.initDatabase();
    await db.deleteNote(id);
    await db.closeDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: FutureBuilder(
          future: getNotes(),
          builder: (context, noteItems) {
            if (noteItems.data != null) {
              return body(noteItems);
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

  Widget body(noteItems) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: noteItems.data.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic reverse = List.from(noteItems.data.reversed);
                  dynamic? note = reverse[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(
                          note['title'] ?? '',
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 30),
                          child: Text(
                            note['content'] ?? '',
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateScreen(id: note['id'])))
                              .then((value) => setState(() {}));
                        },
                        onLongPress: () {
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
                                      onPressed: () {
                                        deleteNote(note['id'])
                                            .then((value) => setState((() {})));
                                        Navigator.pop(context, true);
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                  );
                }),
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
}

import 'package:flutter/material.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/provider/home_provider.dart';
import 'package:note/screens/addNote.dart';
import 'package:note/screens/update.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: Consumer<HomeProvider>(
        builder: (context, myType, child) {
          if (myType.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return body(context, myType.notes);
        },
      ),
    );
  }

  Widget body(BuildContext context, noteItems) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: noteItems.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic reverse = List.from(noteItems.reversed);
                  dynamic note = reverse[index];
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
                        onTap: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UpdateScreen(
                                myMap: note,
                              ),
                            ),
                          );
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
                                        context.read<HomeProvider>().deleteNote(note['id']);
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

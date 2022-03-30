import 'package:note/helpers/dbHelper.dart';

class NoteModel {
  int? id;
  String? title;
  String? content;

  NoteModel(this.title, this.content, {this.id});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    data['title'] = title;
    data['content'] = content;
    return data;
  }

  static Future<List> fromListOfMap(List<Map<String, dynamic>> notes) async {
    List items = notes
        .map((value) =>
            NoteModel(value['title'], value['content'], id: value['id']))
        .toList();
    return items;
  }

  static Future<NoteModel> fromMap(Map<String, dynamic> notes) async {
    NoteModel items =
        NoteModel(notes['title'], notes['content'], id: notes['id']);
    return items;
  }
}

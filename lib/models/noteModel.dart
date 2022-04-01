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
    List items = notes.map(NoteModel.fromMap).toList();
    return items;
  }

  factory NoteModel.fromMap(Map<String, dynamic> notes) => NoteModel(
        notes['title'],
        notes['content'],
        id: notes['id'],
      );
}

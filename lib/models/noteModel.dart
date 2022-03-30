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
}

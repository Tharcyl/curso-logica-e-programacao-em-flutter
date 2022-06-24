class Todo {
  Todo(this.title, this.done);

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        done = json['done'];

  final String title;
  bool done = false;

  void toggleDone() {
    done = !done;
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'done': done};
  }
}

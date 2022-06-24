class Todo {
  Todo(this.title);

  final String title;
  bool done = false;

  void toggleDone() {
    done = !done;
  }
}

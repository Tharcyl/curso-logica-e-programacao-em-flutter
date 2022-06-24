import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/pages/edit_todo_page.dart';
import 'package:todolist/widgets/todo_list_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [];

  late SharedPreferences sharedPreferences;

  Todo? deletedTodo;
  int? deletedPosition;

  @override
  void initState() {
    super.initState();

    loadTodos();
  }

  void loadTodos() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String j = sharedPreferences.getString('todos_key') ?? '[]';
    final List list = json.decode(j);
    setState(() {
      todos = list.map<Todo>((m) => Todo.fromJson(m)).toList();
    });
  }

  void saveTodos() {
    final j = json.encode(todos);
    sharedPreferences.setString('todos_key', j);
  }

  void addTodo() async {
    final value = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTodoPage(),
      ),
    );
    if (value != null) {
      setState(() {
        todos.add(value);
      });
      saveTodos();
    }
  }

  void removeTodo(Todo todo) {
    deletedTodo = todo;
    deletedPosition = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });
    saveTodos();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Tarefa ${todo.title} foi deletada.',
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              todos.insert(deletedPosition!, deletedTodo!);
            });
            saveTodos();
          },
        ),
      ),
    );
  }

  void editTodo(Todo todo) async {
    final value = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => EditTodoPage(todo: todo)),
    );
    if (value != null) {
      setState(() {
        final index = todos.indexOf(todo);
        todos.removeAt(index);
        todos.insert(index, value);
      });
      saveTodos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(1000, double.infinity)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lista de Tarefas',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: addTodo,
                        color: Colors.white,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    elevation: 16,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];

                        return TodoListItem(
                          todo: todo,
                          onEditPressed: () => editTodo(todo),
                          onRemovePressed: () => removeTodo(todo),
                          onItemModified: saveTodos,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

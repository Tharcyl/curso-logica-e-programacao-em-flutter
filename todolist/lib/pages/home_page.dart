import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/pages/edit_todo_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todo> todos = [];

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
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
                    onPressed: () async {
                      final value = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditTodoPage(),
                        ),
                      );
                      if (value != null) {
                        setState(() {
                          todos.add(value);
                        });
                      }
                    },
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
                elevation: 16,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          todo.toggleDone();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          todo.title,
                          style: TextStyle(
                            color: todo.done ? Colors.grey[300] : Colors.black,
                            decoration:
                                todo.done ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

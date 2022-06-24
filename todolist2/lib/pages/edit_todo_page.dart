import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';

class EditTodoPage extends StatefulWidget {
  EditTodoPage({this.todo});

  final Todo? todo;

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late String todoText = widget.todo?.title ?? '';

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
                        'Criar Tarefa',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: todoText.isEmpty
                            ? null
                            : () {
                                final Todo newTodo =
                                    Todo(todoText, widget.todo?.done ?? false);
                                Navigator.of(context).pop(newTodo);
                              },
                        color: Colors.white,
                        icon: Icon(Icons.save),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Card(
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 16,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: TextFormField(
                          initialValue: todoText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Insira sua tarefa',
                          ),
                          cursorColor: Colors.deepPurple,
                          onChanged: (text) {
                            setState(() {
                              todoText = text;
                            });
                          },
                        ),
                      ),
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

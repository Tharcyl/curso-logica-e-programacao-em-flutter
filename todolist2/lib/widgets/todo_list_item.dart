import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/models/todo.dart';

class TodoListItem extends StatefulWidget {
  TodoListItem({
    required this.todo,
    required this.onEditPressed,
    required this.onRemovePressed,
    required this.onItemModified,
  });

  final Todo todo;
  final VoidCallback onEditPressed;
  final VoidCallback onRemovePressed;
  final VoidCallback onItemModified;

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.18,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.todo.toggleDone();
          });
          widget.onItemModified();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            widget.todo.title,
            style: TextStyle(
              color: widget.todo.done ? Colors.grey[300] : Colors.black,
              decoration: widget.todo.done ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Editar',
          color: Colors.transparent,
          foregroundColor: Colors.deepPurple,
          icon: Icons.edit,
          onTap: widget.onEditPressed,
        ),
        IconSlideAction(
          caption: 'Deletar',
          color: Colors.transparent,
          foregroundColor: Colors.red,
          icon: Icons.delete,
          onTap: widget.onRemovePressed,
        ),
      ],
    );
  }
}

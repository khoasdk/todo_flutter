import 'package:flutter/material.dart';
import 'package:todo_flutter/models/todo.dart';

class TodoDetailScreen extends StatefulWidget {
  final Todo todo;

  TodoDetailScreen(this.todo);

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  Todo todo;

  @override
  void initState() {
    super.initState();
    todo = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.of(context).pop<bool>(true),
        ),
        title: Text('Edit Todo ${todo.id}'),
      ),
      body: Container(color: Colors.red),
    );
  }
}

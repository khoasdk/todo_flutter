import 'package:flutter/material.dart';
import 'package:todo_flutter/models/todo.dart';
import 'package:todo_flutter/screens/todo_detail_screen.dart';
import 'package:todo_flutter/utils/db_helper.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final helper = DBHelper.instance;
  var todos = List<Todo>();
  var count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Flutter'),
      ),
      body: FutureBuilder(
        future: updateList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: count,
            itemBuilder: (context, pos) {
              final todo = todos[pos];
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: Key(todo.id.toString()),
                child: ListTile(
                  title: Text(todo.id.toString()),
                ),
                background: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Swipe to Delete'),
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    helper.deleteTodo(todo.id);
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var todo = Todo('title here...', DateTime.now().toString(), 'description here...');
          var id = await helper.insertTodo(todo);
          navigateToDetail(id);
        },
      ),
    );
  }

  Future updateList() async {
    todos = await helper.getTodos();
    count = await helper.getCount();
  }

  void refreshScreen() {
    setState(() {});
  }

  void navigateToDetail(int id) async {
    var todo = await helper.getTodo(id);
    print('TODO ID: ${todo.id}');
    var result = await Navigator.of(context).push(
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => TodoDetailScreen(todo),
      ),
    );
    if (result == true) refreshScreen();
  }
}

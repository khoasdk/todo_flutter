import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_flutter/models/todo.dart';

class DBHelper {
  static final _dbName = 'todos.db';
  static final _dbVersion = 1;

  static final table = 'todos';

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  static final columnPriority = 'priority';
  static final columnDate = 'date';

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + _dbName;
    return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT,
        $columnDescription TEXT,
        $columnPriority INTEGER,
        $columnDate TEXT,
      )
    ''');
  }

  Future<List<Todo>> getTodos() async {
    Database db = await database;
    List<Map<String, dynamic>> data = await db.query(table);
    List<Todo> todos = List<Todo>();
    for (int i = 0; i < data.length; i++) {
      todos.add(Todo.fromMap(data[i]));
    }
    return todos;
  }

  Future<int> getCount() async {
    Database db = await database;
    var result = await db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(result);
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await database;
    var result = await db.insert(table, todo.toMap());
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    Database db = await database;
    var result = await db.update(table, todo.toMap(), where: '$columnId = ?', whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    Database db = await database;
    var result = await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    return result;
  }
}
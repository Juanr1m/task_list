import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'models/task.dart';

class TaskDatabase {
  final _databaseName = "task.db";
  final _databaseVersion = 1;
  final mytable = 'task_table';
  final columnId = 'id';
  final columnName = 'title';
  final columnDate = 'date';
  final columnStatus = 'status';

  static final TaskDatabase _instance = TaskDatabase.internal();
  Database? _database;
  TaskDatabase.internal();
  factory TaskDatabase() => _instance;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, _databaseName);

    // SQL code to create the database table
    var db =
        await openDatabase(path, version: _databaseVersion, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $mytable (
             $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT,
            $columnDate TEXT,
            $columnStatus TEXT
          )
          ''');
  }

  // get full tasks
  Future<List<Task>> getFullTasks() async {
    final db = await database;
    List<Map> list = [];
    list = await db!.rawQuery('select *from $mytable');
    List<Task> note = [];
    list.forEach((e) => note.add(Task(
        title: e["title"],
        date: DateTime.parse(e["date"]),
        status: e["status"])));
    return note;
  }

  // to add data in box
  Future<int> addToBox(Task task) async {
    final db = await database;
    var res = await db!.insert(mytable, task.toMap());
    return res;
  }

  // delete data from box
  Future<int> deleteFromBox(int index) async {
    final db = await database;
    var res = db!.delete(mytable, where: '$columnId = ?', whereArgs: [index]);
    return res;
  }

  // delete all data from box
  Future<void> deleteAll() async {
    final db = await database;
    await db!.delete(mytable);
  }

  // update data
  Future<int> updateTask(int? index, Task task) async {
    final db = await database;
    var res = await db!.update(mytable, task.toMap(),
        where: '$columnId = ?', whereArgs: [index]);
    return res;
  }
}

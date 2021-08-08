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

  Future<List<Task>> getFullTasks(int id) async {
    final db = await database;
    List<Map> list = [];
    if (id == 1)
      list = await db!.rawQuery('select *from $mytable');
    else if (id == 2)
      list = await db!.rawQuery(
          'select *from $mytable WHERE $columnStatus = "В прогрессе"');
    else
      list = await db!
          .rawQuery('select *from $mytable WHERE $columnStatus = "Выполнено"');

    List<Task> note = [];
    list.forEach((e) => note.add(Task(
        title: e["title"],
        date: DateTime.parse(e["date"]),
        status: e["status"])));
    return note;
  }

  Future<int> addToBox(Task task) async {
    final db = await database;
    var res = await db!.insert(mytable, task.toMap());
    return res;
  }

  Future deleteFromBox(String title, String date, String status) async {
    final db = await database;
    var res = db!.rawQuery(
        'DELETE from $mytable WHERE $columnName = "$title" AND $columnDate = "$date" AND $columnStatus = "$status"');
    return res;
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db!.delete(mytable);
  }

  Future updateTask(Task task, Task oldTask) async {
    final db = await database;
    var res = await db!.rawQuery(
        'UPDATE $mytable SET $columnName = "${task.title}", $columnDate = "${task.date.toIso8601String()}", $columnStatus = "${task.status}" WHERE $columnName = "${oldTask.title}" AND $columnDate = "${oldTask.date.toIso8601String()}" AND $columnStatus = "${oldTask.status}"');
    return res;
  }
}

import 'package:agrobank_test/repositories/db.dart';
import 'package:agrobank_test/repositories/models/task.dart';

class DataRepository {
  static const TIME = 10;
  TaskDatabase databaseHelper = TaskDatabase();

  Future<List<Task>> getFullTasks() =>
      databaseHelper.getFullTasks().timeout(Duration(seconds: TIME));

  Future<int> addToBox(Task task) =>
      databaseHelper.addToBox(task).timeout(Duration(seconds: TIME));

  Future deleteAll() =>
      databaseHelper.deleteAll().timeout(Duration(seconds: TIME));

  Future deleteFromBox(int index) =>
      databaseHelper.deleteFromBox(index).timeout(Duration(seconds: TIME));

  Future updateTask(int index, Task task) =>
      databaseHelper.updateTask(index, task).timeout(Duration(seconds: TIME));
}

import 'package:aliftech_test/repositories/db.dart';
import 'package:aliftech_test/repositories/models/task.dart';

class DataRepository {
  static const TIME = 10;
  TaskDatabase databaseHelper = TaskDatabase();

  Future<List<Task>> getFullTasks(int id) =>
      databaseHelper.getFullTasks(id).timeout(Duration(seconds: TIME));

  Future<int> addToBox(Task task) =>
      databaseHelper.addToBox(task).timeout(Duration(seconds: TIME));

  Future deleteAll() =>
      databaseHelper.deleteAll().timeout(Duration(seconds: TIME));

  Future deleteFromBox(String title, String date, String status) =>
      databaseHelper
          .deleteFromBox(title, date, status)
          .timeout(Duration(seconds: TIME));

  Future updateTask(Task task, Task oldTask) =>
      databaseHelper.updateTask(task, oldTask).timeout(Duration(seconds: TIME));
}

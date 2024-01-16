import 'package:sqflite/sqflite.dart';
import 'package:task_manager/Models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "Tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}tasks.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title STRING, discreption TEXT, date STRING,"
          "startTime STRING, endTime STRING,"
          "remind INTEGER, repeat STRING,"
          "color INTERGER,"
          "isCompleted INTERGER)",
        );
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    // ignore: avoid_print
    print("Query Function Called");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: "id=?", whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
  UPDATE tasks
  SET isCompleted = ?
  WHERE id = ?
''', [1, id]);
  }

  static Future<int> updateTask(
      int id, String title, String discreption) async {
    final db = DBHelper._db;

    final data = {
      'title': title,
      'discreption': discreption,
    };
    final reslut =
        await db!.update('tasks', data, where: "id = ?", whereArgs: [id]);
    return reslut;
  }
}

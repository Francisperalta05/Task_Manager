import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DatabaseService {
  Database? db;
  final String tableName = 'Task_tbl';

  static const String columnId = "id";
  static const String columnTitle = "title";
  static const String columnDescription = "description";
  static const String columnCompleted = "completed";
  static const String columnCreated = "createdAt";
  static const String columnUpdated = "lastUpdated";

  Future<List<TaskModel>> fetchTasks() async {
    await open();

    await db!.execute('''
        CREATE TABLE IF NOT EXISTS $tableName (
        $columnId integer primary key autoincrement, 
        $columnTitle text not null,
        $columnDescription text not null,
        $columnCompleted integer not null,
        $columnCreated text not null,
        $columnUpdated text not null)
  ''');

    return await getTaskList();
  }

  Future<void> open() async {
    try {
      final databasesPath = await getDatabasesPath();

      db ??= await openDatabase("$databasesPath/task.db");
    } on Exception {
      rethrow;
    }
  }

  Future<int?> insert(TaskModel task) async {
    try {
      final id = await db!.insert(tableName, task.toJson());
      return id;
    } on Exception {
      rethrow;
    }
  }

  Future<List<TaskModel>> getTaskList([int id = 0]) async {
    List<Map> maps = await db!.query(tableName);

    if (maps.isNotEmpty) {
      return taskModelFromJson(json.encode(maps));
    }
    return [];
  }

  Future<int> delete(int id) async {
    return await db!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> completeTask(int id) async => await db!.update(
        tableName,
        {
          columnCompleted: 1,
          columnUpdated: DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );

  Future close() async => db?.close();
}

import 'dart:convert';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

Database? db;

class DatabaseService {
  final String tableName = 'Task_tbl';

  static const String columnId = "id";
  static const String columnTitle = "title";
  static const String columnDescription = "description";
  static const String columnCompleted = "completed";
  static const String columnCreated = "createdAt";
  static const String columnUpdated = "lastUpdated";

  Future<List<TaskModel>> fetchTasks() async {
    final databasesPath = await getDatabasesPath();

    db ??= await open("$databasesPath/task.db");

    await db!.execute('''
        CREATE TABLE IF NOT EXISTS $tableName (
        $columnId integer primary key autoincrement, 
        $columnTitle text not null,
        $columnDescription text not null,
        $columnCompleted integer not null,
        $columnCreated text not null,
        $columnUpdated text not null)
  ''');

    return await getTodo();
  }

  Future completeTask(int taskId) async {
    log("$taskId");
  }

  Future<Database> open(String path) async {
    try {
      db = await openDatabase(path);

      return db!;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<int?> insert(TaskModel task) async {
    try {
      final id = await db!.insert(tableName, task.toJson());
      return id;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<List<TaskModel>> getTodo([int id = 0]) async {
    List<Map> maps = await db!.query(
      tableName,
      // columns: [
      //   columnId,
      //   columnTitle,
      //   columnDescription,
      //   columnCompleted,
      //   columnCreated,
      //   columnUpdated,
      // ],
      // where: '$columnId = ?',
      // whereArgs: [id],
    );
    // log(json.encode(maps));
    if (maps.isNotEmpty) {
      return taskModelFromJson(json.encode(maps));
    }
    return [];
  }

  Future<int> delete(int id) async {
    return await db!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(TaskModel todo) async {
    return await db!.update(tableName, todo.toJson(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db!.close();
}

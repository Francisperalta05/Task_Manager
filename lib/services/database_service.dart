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

  DatabaseService({this.db});

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

  Future<Database> open(String path) async {
    try {
      final dbOpen = await openDatabase(path);

      return dbOpen;
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

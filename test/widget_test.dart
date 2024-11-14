import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/database_service.dart';

void main() {
  late Database dbTest;
  late DatabaseService dbHelper;

  setUp(() async {
    dbTest = await openDatabase(
      inMemoryDatabasePath,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE items (id INTEGER PRIMARY KEY, nombre TEXT)');
      },
      version: 1,
    );

    dbHelper = DatabaseService(db: dbTest);
  });

  tearDown(() async {
    await dbHelper.close();
  });

  test('Insertar un item en la base de datos', () async {
    final item = TaskModel(
      title: "Test Title",
      description: "description",
      completed: true,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );
    await dbHelper.insert(item);

    List<TaskModel> items = await dbHelper.fetchTasks();

    expect(items.length, 1);
    expect(items.first.title, 'Test Title');
  });

  test('Delete Item', () async {
    final item = TaskModel(
      title: "Test Delete",
      description: "description",
      completed: true,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );
    await dbHelper.insert(item);

    List<TaskModel> itemsBefore = await dbHelper.fetchTasks();
    expect(itemsBefore.length, 1);

    await dbHelper.delete(itemsBefore.first.id!);

    List<TaskModel> itemsAfter = await dbHelper.fetchTasks();
    expect(itemsAfter.length, 0);
  });
}

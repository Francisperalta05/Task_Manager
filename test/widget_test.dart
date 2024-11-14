import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/database_service.dart';

void main() {
  late DatabaseService databaseService;

  // Initialize the database service before each test
  setUp(() async {
    databaseService = DatabaseService();
    // Create the database in memory for each test
    await databaseService.fetchTasks();
  });

  // Close the database after each test
  tearDown(() async {
    await databaseService.close();
  });

  // Test: Inserting a task
  test('Insert a task into the database', () async {
    TaskModel task = TaskModel(
      title: 'Test Task',
      description: 'Task description',
      completed: false,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );

    // Insert the task into the database
    final id = await databaseService.insert(task);
    expect(id, isNotNull);

    // Fetch the task from the database and verify
    final tasks = await databaseService.getTodo();
    expect(tasks.length, 1);
    expect(tasks.first.title, 'Test Task');
    expect(tasks.first.description, 'Task description');
  });

  // Test: Fetching tasks
  test('Fetch tasks from the database', () async {
    // Insert a task first
    TaskModel task = TaskModel(
      id: 0,
      title: 'Test Task Fetch',
      description: 'Test task fetch description',
      completed: false,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );

    await databaseService.insert(task);

    // Fetch tasks
    final tasks = await databaseService.getTodo();
    expect(tasks.isNotEmpty, true);
    expect(tasks.first.title, 'Test Task Fetch');
  });

  // Test: Completing a task
  test('Complete a task in the database', () async {
    // Insert a task first
    TaskModel task = TaskModel(
      id: 0,
      title: 'Test Task Complete',
      description: 'Complete task description',
      completed: false,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );

    final taskId = await databaseService.insert(task);

    // Complete the task
    final updatedRows = await databaseService.completeTask(taskId!);
    expect(updatedRows, 1);

    // Fetch the task to verify it's marked as completed
    final tasks = await databaseService.getTodo();
    expect(tasks.first.completed, 1); // Verify the task is completed
  });

  // Test: Deleting a task
  test('Delete a task from the database', () async {
    // Insert a task first
    TaskModel task = TaskModel(
      id: 0,
      title: 'Test Task Delete',
      description: 'Delete task description',
      completed: false,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );

    final taskId = await databaseService.insert(task);

    // Delete the task
    final deletedRows = await databaseService.delete(taskId!);
    expect(deletedRows, 1);

    // Verify the task is deleted
    final tasks = await databaseService.getTodo();
    expect(tasks.isEmpty, true);
  });
}

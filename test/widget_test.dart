import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/database_service.dart';

void main() {
  late DatabaseService databaseService;

  // Initialize the database service before each test
  setUp(() async {
    // Ensure tests run only on mobile platforms (iOS or Android)
    if (defaultTargetPlatform != TargetPlatform.iOS &&
        defaultTargetPlatform != TargetPlatform.android) {
      // If not on mobile platform, skip all tests
      print("Skipping tests on non-mobile platform.");
      return;
    }

    databaseService = DatabaseService();
    // Create the database in memory for each test
    await databaseService.fetchTasks();
  });

  // Close the database after each test
  tearDown(() async {
    await databaseService.close();
  });

  // Group the tests related to the database service
  group('Database Service Tests', () {
    // Test: Inserting a task
    test('Insert a task into the database', () async {
      if (defaultTargetPlatform != TargetPlatform.iOS &&
          defaultTargetPlatform != TargetPlatform.android) {
        return; // Skip this test on non-mobile platforms
      }

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
      final tasks = await databaseService.getTaskList();
      expect(tasks.length, 1);
      expect(tasks.first.title, 'Test Task');
      expect(tasks.first.description, 'Task description');
    });

    // Test: Fetching tasks
    test('Fetch tasks from the database', () async {
      if (defaultTargetPlatform != TargetPlatform.iOS &&
          defaultTargetPlatform != TargetPlatform.android) {
        return; // Skip this test on non-mobile platforms
      }

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
      final tasks = await databaseService.getTaskList();
      expect(tasks.isNotEmpty, true);
      expect(tasks.first.title, 'Test Task Fetch');
    });

    // Test: Completing a task
    test('Complete a task in the database', () async {
      if (defaultTargetPlatform != TargetPlatform.iOS &&
          defaultTargetPlatform != TargetPlatform.android) {
        return; // Skip this test on non-mobile platforms
      }

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
      final tasks = await databaseService.getTaskList();
      expect(tasks.first.completed, 1); // Verify the task is completed
    });

    // Test: Deleting a task
    test('Delete a task from the database', () async {
      if (defaultTargetPlatform != TargetPlatform.iOS &&
          defaultTargetPlatform != TargetPlatform.android) {
        return; // Skip this test on non-mobile platforms
      }

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
      final tasks = await databaseService.getTaskList();
      expect(tasks.isEmpty, true);
    });
  });
}

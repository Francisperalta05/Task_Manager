import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../models/task.dart';
import '../../services/database_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseService taskService;

  TaskBloc(this.taskService) : super(const TaskState()) {
    on<LoadTasks>(_loadTask);
    on<AddTask>(_addTask);
    on<CompleteTask>(_completeTask);
    on<DeleteTask>(_deleteTask);
  }

  //TODO: Complete methods
  FutureOr<void> _completeTask(CompleteTask event, Emitter<TaskState> emit) {}

  FutureOr<void> _deleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await taskService.delete(event.taskId);
      add(LoadTasks());
    } catch (e) {
      emit.call(state.copyWith(
        taskLoading: false,
        hasError: true,
        errorMessage: "Failed to delete tasks $e",
      ));
    }
  }

  FutureOr<void> _addTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      await taskService.insert(
        TaskModel(
          title: event.title,
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now(),
          completed: 0,
          description: event.description,
        ),
      );
      Future.delayed(Durations.medium4, () => add(LoadTasks()));
    } catch (e) {
      emit.call(state.copyWith(
          taskLoading: false,
          hasError: true,
          errorMessage: "Failed to add tasks $e"));
    }
  }

  FutureOr<void> _loadTask(LoadTasks event, Emitter<TaskState> emit) async {
    emit.call(state.copyWith(taskLoading: true));
    try {
      final tasks = await taskService.fetchTasks();
      emit.call(state.copyWith(taskLoading: false, tasks: tasks));
    } catch (e) {
      emit.call(state.copyWith(
          taskLoading: false,
          hasError: true,
          errorMessage: "Failed to load tasks $e"));
    }
  }
}

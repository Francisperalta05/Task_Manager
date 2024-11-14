import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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
    // on<FilterTask>(_filterTask);
    on<CompleteChecks>((event, emit) {
      emit.call(state.copyWith(completeFilter: event.completed));
    });
    on<InCompleteChecks>((event, emit) {
      emit.call(state.copyWith(incompleteFilter: event.incomplete));
    });
  }

  // FutureOr<void> _filterTask(FilterTask event, Emitter<TaskState> emit) {
  //   final taskFilter = state.tasks.where((element) {
  //     if (event.completed && event.incomplete) {
  //       return true;
  //     } else if (event.completed) {
  //       return element.completed;
  //     } else if (event.incomplete) {
  //       return !element.completed;
  //     }
  //     return true;
  //   }).toList();
  //   emit.call(
  //     state.copyWith(
  //       completeFilter: event.completed,
  //       incompleteFilter: event.incomplete,
  //       tasks: taskFilter,
  //     ),
  //   );
  // }

  Future<void> _completeTask(
      CompleteTask event, Emitter<TaskState> emit) async {
    try {
      await taskService.completeTask(event.taskId);
      add(LoadTasks(true, true));
    } catch (e) {
      emit.call(state.copyWith(
        taskLoading: false,
        hasError: true,
        errorMessage: "Failed to delete tasks $e",
      ));
    }
  }

  FutureOr<void> _deleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await taskService.delete(event.taskId);
      add(LoadTasks(true, true));
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
          completed: false,
          description: event.description,
        ),
      );
      add(LoadTasks(true, true));
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

      final taskFilter = tasks.where((element) {
        if (event.completed && event.incomplete) {
          return true;
        } else if (event.completed) {
          return element.completed;
        } else if (event.incomplete) {
          return !element.completed;
        }
        return true;
      }).toList();
      emit.call(state.copyWith(taskLoading: false, tasks: taskFilter));
    } catch (e) {
      emit.call(state.copyWith(
          taskLoading: false,
          hasError: true,
          errorMessage: "Failed to load tasks $e"));
    }
  }
}

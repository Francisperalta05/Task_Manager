part of 'task_bloc.dart';

@immutable
class TaskState {
  final List<TaskModel> tasks;
  final String errorMessage;
  final bool taskLoading;
  final bool hasError;
  final bool completeFilter;
  final bool incompleteFilter;

  const TaskState({
    this.tasks = const [],
    this.errorMessage = "",
    this.taskLoading = false,
    this.hasError = false,
    this.completeFilter = false,
    this.incompleteFilter = false,
  });

  TaskState copyWith({
    List<TaskModel>? tasks,
    String? errorMessage,
    bool? taskLoading,
    bool? hasError,
    bool? completeFilter,
    bool? incompleteFilter,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
      taskLoading: taskLoading ?? this.taskLoading,
      hasError: hasError ?? this.hasError,
      completeFilter: completeFilter ?? this.completeFilter,
      incompleteFilter: incompleteFilter ?? this.incompleteFilter,
    );
  }
}

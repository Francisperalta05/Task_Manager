part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String description;
  AddTask(
    this.title,
    this.description,
  );
}

class DeleteTask extends TaskEvent {
  final int taskId;
  DeleteTask(this.taskId);
}

class CompleteTask extends TaskEvent {
  final int taskId;
  CompleteTask(this.taskId);
}

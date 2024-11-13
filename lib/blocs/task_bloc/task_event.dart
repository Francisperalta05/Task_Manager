part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String taskName;
  AddTask(this.taskName);
}

class DeleteTask extends TaskEvent {
  final String taskId;
  DeleteTask(this.taskId);
}

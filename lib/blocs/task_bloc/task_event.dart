part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTasks extends TaskEvent {
  final bool completed;
  final bool incomplete;

  LoadTasks(this.completed, this.incomplete);
}

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

class CompleteChecks extends TaskEvent {
  final bool completed;

  CompleteChecks(this.completed);
}

class InCompleteChecks extends TaskEvent {
  final bool incomplete;

  InCompleteChecks(this.incomplete);
}

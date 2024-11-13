import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/task.dart';
import '../../services/database_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseService taskService;

  TaskBloc(this.taskService) : super(TaskState()) {
    on<TaskEvent>((event, emit) {
      mapEventToState(event);
    });
  }

  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is LoadTasks) {
      yield TaskLoading();
      try {
        final tasks = await taskService.fetchTasks();
        yield TaskLoaded(tasks);
      } catch (e) {
        yield TaskError("Failed to load tasks");
      }
    } else if (event is AddTask) {
      try {
        await taskService.addTask(event.taskName);
        add(LoadTasks());
      } catch (e) {
        yield TaskError("Failed to add task");
      }
    } else if (event is DeleteTask) {
      try {
        await taskService.deleteTask(event.taskId);
        add(LoadTasks());
      } catch (e) {
        yield TaskError("Failed to delete task");
      }
    }
  }
}

import '../blocs/task_bloc/task_bloc.dart';
import '../services/database_service.dart';

class TaskController {
  final TaskBloc taskBloc;

  TaskController() : taskBloc = TaskBloc(DatabaseService());

  void loadTasks() {
    taskBloc.add(LoadTasks());
  }

  void addTask(String taskName) {
    taskBloc.add(AddTask(taskName));
  }

  void deleteTask(String taskId) {
    taskBloc.add(DeleteTask(taskId));
  }

  void dispose() {
    taskBloc.close();
  }
}

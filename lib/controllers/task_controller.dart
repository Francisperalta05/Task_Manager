import '../blocs/task_bloc/task_bloc.dart';
import '../services/database_service.dart';

class TaskController {
  final TaskBloc taskBloc;

  TaskController() : taskBloc = TaskBloc(DatabaseService());

  void loadTasks() => taskBloc.add(LoadTasks());

  void addTask(String taskName, String description) =>
      taskBloc.add(AddTask(taskName, description));

  void deleteTask(int taskId) => taskBloc.add(DeleteTask(taskId));

  void completeTask(int taskId) => taskBloc.add(CompleteTask(taskId));

  void dispose() {
    taskBloc.close();
  }
}

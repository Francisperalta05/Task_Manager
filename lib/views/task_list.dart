import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/extensions/sizer.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../controllers/task_controller.dart';
import 'add_task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});
  static const String routeName = "/task_list";

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late TaskController taskController;

  @override
  void initState() {
    taskController = TaskController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => taskController.taskBloc..add(LoadTasks()),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text("Task List"),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state.taskLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.primaryColor,
                  ),
                ),
              );
            } else if (state.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(8.0.w),
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0.h),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0.w),
                    title: Text(
                      task.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      task.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    leading: Icon(
                      Icons.task,
                      color: theme.primaryColor,
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () => taskController.completeTask(task.id!),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 28.w,
                              ),
                              SizedBox(width: 10.w),
                              const Text("Set as complete"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () => taskController.deleteTask(task.id!),
                          child: Row(
                            children: [
                              Icon(
                                Icons.clear_rounded,
                                color: Colors.redAccent,
                                size: 28.w,
                              ),
                              SizedBox(width: 10.w),
                              const Text("Remove task"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AddTaskView.routeName),
          backgroundColor: theme.primaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

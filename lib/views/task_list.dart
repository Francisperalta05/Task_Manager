import 'dart:developer';

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
      create: (_) => taskController.taskBloc..add(LoadTasks(true, true)),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text("Task List"),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertFilter(taskController: taskController);
                  },
                );
              },
              icon: Icon(Icons.filter_list_outlined),
            )
          ],
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            log(state.tasks.length.toString());
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
            } else if (state.tasks.isEmpty) {
              return Center(
                child: Icon(
                  Icons.task,
                  size: 100,
                  color: Colors.black12,
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
                      task.completed
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked_rounded,
                      color: task.completed ? theme.primaryColor : Colors.red,
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        if (!task.completed)
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
          onPressed: () => Navigator.of(context).pushNamed(
            AddTaskView.routeName,
            arguments: taskController,
          ),
          backgroundColor: theme.primaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class AlertFilter extends StatelessWidget {
  const AlertFilter({
    super.key,
    required this.taskController,
  });

  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return AlertDialog.adaptive(
          title: Text("Filter Tasks"),
          content: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Completed"),
                  value: state.completeFilter,
                  onChanged: (value) =>
                      context.read<TaskBloc>().add(CompleteChecks(value!)),
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("Incomplete"),
                  value: state.incompleteFilter,
                  onChanged: (value) =>
                      context.read<TaskBloc>().add(InCompleteChecks(value!)),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                taskController.taskBloc.add(
                  LoadTasks(
                    state.completeFilter,
                    state.incompleteFilter,
                  ),
                );
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }
}

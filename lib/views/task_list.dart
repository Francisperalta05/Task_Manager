// lib/views/task_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../controllers/task_controller.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
    return BlocProvider(
      create: (_) => taskController.taskBloc..add(LoadTasks()),
      child: Scaffold(
        appBar: AppBar(title: Text("Tasks")),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is TaskLoaded) {
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => taskController.deleteTask(task.id),
                    ),
                  );
                },
              );
            } else if (state is TaskError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => taskController.addTask("New Task"),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

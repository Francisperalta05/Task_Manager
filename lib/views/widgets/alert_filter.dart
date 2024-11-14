import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/task_bloc/task_bloc.dart';
import '../../controllers/task_controller.dart';

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
          title: const Text("Filter Tasks"),
          content: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("Completed"),
                  value: state.completeFilter,
                  onChanged: (value) =>
                      context.read<TaskBloc>().add(CompleteChecks(value!)),
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("Incomplete"),
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
              child: const Text("Cancel"),
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
              child: const Text("Apply"),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/blocs/task_bloc/task_bloc.dart';
import 'package:task_manager/routes/routes.dart';
import 'package:task_manager/services/database_service.dart';

import 'utils/themes.dart';
import 'views/task_list.dart';

void main() {
  runApp(const TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc(DatabaseService())),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        theme: themes,
        routes: getAppRoutes,
        initialRoute: TaskList.routeName,
      ),
    );
  }
}

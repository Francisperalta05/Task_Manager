import 'package:flutter/material.dart';
import 'package:task_manager/views/add_task.dart';

import '../views/task_list.dart';

Map<String, WidgetBuilder> get getAppRoutes => <String, WidgetBuilder>{
      TaskList.routeName: (_) => const TaskList(),
      AddTaskView.routeName: (_) => const AddTaskView(),
    };

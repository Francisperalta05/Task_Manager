import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../utils/themes.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  static const String routeName = "/add_task";

  @override
  State<AddTaskView> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late TaskController taskController;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      Navigator.pop(context);
      taskController.addTask(title, description);
    }
  }

  @override
  Widget build(BuildContext context) {
    taskController =
        ModalRoute.settingsOf(context)?.arguments as TaskController;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Add New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    border: outlineInputBorder,
                    prefixIcon: const Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: outlineInputBorder,
                    prefixIcon: const Icon(Icons.description),
                  ),
                  maxLines: 4, // Permite que se ingrese más de una línea
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return null;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text(
                    'Save Task',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

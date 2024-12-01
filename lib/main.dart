import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoModel(),
      child: MaterialApp(
        home: TodoApp(),
      ),
    );
  }
}

class TodoApp extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App with Provider"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: "Add a task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      Provider.of<TodoModel>(context, listen: false)
                          .addTask(_taskController.text);
                      _taskController.clear();
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TodoModel>(
              builder: (context, todoModel, child) {
                return ListView.builder(
                  itemCount: todoModel.tasks.length,
                  itemBuilder: (context, index) {
                    final task = todoModel.tasks[index];
                    return ListTile(
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          decoration: task['completed']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Checkbox(
                        value: task['completed'],
                        onChanged: (value) {
                          todoModel.toggleTask(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

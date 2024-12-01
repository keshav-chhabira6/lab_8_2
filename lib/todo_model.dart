import 'package:flutter/foundation.dart';

class TodoModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add({'title': title, 'completed': false});
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index]['completed'] = !_tasks[index]['completed'];
    notifyListeners();
  }
}

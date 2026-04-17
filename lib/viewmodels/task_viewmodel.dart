import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index, Task task) {
    _tasks[index] = task;
    notifyListeners();
  }

  List<Task> get todayTasks {
    final now = DateTime.now();
    return _tasks
        .where(
          (task) =>
              task.dateTime.day == now.day &&
              task.dateTime.month == now.month &&
              task.dateTime.year == now.year,
        )
        .toList();
  }

  List<Task> get upcomingTasks {
    final now = DateTime.now();
    return _tasks.where((task) => task.dateTime.isAfter(now)).toList();
  }
}

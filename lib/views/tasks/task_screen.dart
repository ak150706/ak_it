import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../../models/task.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: ListView.builder(
        itemCount: vm.tasks.length,
        itemBuilder: (context, index) {
          final task = vm.tasks[index];

          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(task.dateTime.toString()),
            onTap: () => vm.toggleTask(index),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => vm.deleteTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final now = DateTime.now();

          vm.addTask(Task(title: "New Task", dateTime: now));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../../models/task.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  void _showEditDialog(BuildContext context, TaskViewModel vm, int? index) {
    final isNew = index == null;
    final task = isNew
        ? Task(title: "", dateTime: DateTime.now())
        : vm.tasks[index];
    final titleController = TextEditingController(text: task.title);
    late DateTime selectedDate;
    selectedDate = task.dateTime;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isNew ? "Add Task" : "Edit Task"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Task title"),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    selectedDate = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      selectedDate.hour,
                      selectedDate.minute,
                    );
                  }
                },
                child: Text("Date: ${selectedDate.toString().split(' ')[0]}"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newTask = Task(
                title: titleController.text.isEmpty
                    ? "Untitled"
                    : titleController.text,
                dateTime: selectedDate,
              );
              if (isNew) {
                vm.addTask(newTask);
              } else {
                vm.updateTask(index, newTask);
              }
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

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
            onTap: () => _showEditDialog(context, vm, index),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => vm.deleteTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(context, vm, null),
        child: Icon(Icons.add),
      ),
    );
  }
}

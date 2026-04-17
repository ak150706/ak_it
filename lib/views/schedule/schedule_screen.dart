import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskViewModel>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Schedule"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Today"),
              Tab(text: "Upcoming"),
            ],
          ),
        ),
        body: TabBarView(
          children: [buildList(vm.todayTasks), buildList(vm.upcomingTasks)],
        ),
      ),
    );
  }

  Widget buildList(List tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (_, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.dateTime.toString()),
        );
      },
    );
  }
}

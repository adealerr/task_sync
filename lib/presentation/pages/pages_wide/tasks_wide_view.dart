import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';

class Task {
  final int id;
  final String title;
  final String assignee;
  final TaskStatus status;

  const Task({required this.id, required this.title, required this.assignee, required this.status});
}

enum TaskStatus {
  open('Open'),
  inProgress('In Progress'),
  done('Done');

  const TaskStatus(this.text);

  final String text;
}

class TasksWideView extends StatelessWidget {
  const TasksWideView({required this.tasks, super.key});

  final List<Task> tasks;

  List<Task> _filterTasks(TaskStatus status) => tasks.where((t) => t.status == status).toList();

  Widget _buildColumn(TaskStatus status, List<Task> columnTasks) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(status.text.toUpperCase(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Container(
              color: lightBackgroundSecondary,
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: columnTasks.map((task) => Card(
                  color: lightBackground,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('#${task.id}', style: const TextStyle(color: lightTextMuted)),
                        const SizedBox(height: 6),
                        Text(task.title, style: const TextStyle(fontSize: 16, color: lightText)),
                        const SizedBox(height: 6),
                        Text(task.assignee, style: const TextStyle(color: lightTextMuted)),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ListTile(title: const Text('Задачи')),
        Expanded(
          child: Row(
              children: [
                _buildColumn(TaskStatus.open, _filterTasks(TaskStatus.open)),
                _buildColumn(TaskStatus.inProgress, _filterTasks(TaskStatus.inProgress)),
                _buildColumn(TaskStatus.done, _filterTasks(TaskStatus.done)),
              ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';
import 'package:task_sync/presentation/pages/common_pages/create_task_page.dart';
import 'package:task_sync/presentation/pages/pages_wide/tasks_wide_view.dart';

class TasksNarrowPage extends StatefulWidget {
  const TasksNarrowPage({super.key});

  @override
  State<TasksNarrowPage> createState() => _TasksNarrowPageState();
}

class _TasksNarrowPageState extends State<TasksNarrowPage> {
  final List<Task> tasks = [
    const Task(id: 1, title: 'Сделать авторизацию', assignee: 'Иван Иванов', status: TaskStatus.open),
    const Task(id: 2, title: 'Добавить чат', assignee: 'Мария Смирнова', status: TaskStatus.inProgress),
    const Task(id: 3, title: 'Тестирование задач', assignee: 'Олег Кузнецов', status: TaskStatus.done),
  ];

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  Color _statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.done:
        return lightSuccess;
      case TaskStatus.inProgress:
        return lightWarning;
      default:
        return lightTextMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = tasks.where((Task task) {
      final query = _searchQuery.toLowerCase();

      return task.id.toString().contains(query) ||
          task.title.toLowerCase().contains(query) ||
          task.assignee.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: lightBackground),
                decoration: const InputDecoration(
                  hintText: 'Поиск...',
                  hintStyle: TextStyle(color: lightBackgroundTertiary),
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              )
            : const Text(
                'Задачи',
                style: TextStyle(color: lightBackground),
              ),
        backgroundColor: lightPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
            color: lightBackground,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredTasks.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return Card(
            color: lightBackgroundSecondary,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          '#${task.id}',
                          style: const TextStyle(fontSize: 16, color: lightTextMuted),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(child: Text(task.title, style: const TextStyle(fontSize: 18, color: lightText))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(task.assignee, style: const TextStyle(color: lightTextMuted)),
                  const SizedBox(height: 8),
                  Text(task.status.text.toUpperCase(),
                      style: TextStyle(color: _statusColor(task.status), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightPrimary,
        onPressed: () async {
          final newTask = await Navigator.of(context).push<Task>(
            MaterialPageRoute<Task>(
              builder: (_) => const CreateTaskPage(),
            ),
          );

          if (newTask == null) {
            return;
          }

          tasks.add(newTask);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

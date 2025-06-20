import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';
import 'package:task_sync/presentation/pages/pages_wide/tasks_wide_view.dart';
import 'package:task_sync/utils/platform_helper.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание задачи', style: TextStyle(color: Colors.white)),
        backgroundColor: lightPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const CreateTaskView(),
    );
  }
}

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TaskStatus _selectedStatus = TaskStatus.open;
  String? _selectedAssignee;

  final List<String> _users = [
    'Иван Иванов',
    'Мария Смирнова',
    'Олег Кузнецов',
    'Анна Петрова',
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = PlatformHelper.runningPlatform.isDesktop;

    return Container(
      width: isDesktop ? 600 : double.infinity,
      // constraints: BoxConstraints(maxWidth: isDesktop ? 600 : double.infinity),
      padding: const EdgeInsets.all(16),
      child: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Название задачи
            const Text('Название задачи', style: TextStyle(color: lightText)),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: lightInputBackground,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Введите название задачи',
              ),
            ),
            const SizedBox(height: 16),

            // Статус задачи
            const Text('Статус', style: TextStyle(color: lightText)),
            const SizedBox(height: 6),
            DropdownButtonFormField<TaskStatus>(
              value: _selectedStatus,
              items: TaskStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.text),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedStatus = val!),
              decoration: InputDecoration(
                filled: true,
                fillColor: lightInputBackground,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),

            // Ответственный
            const Text('Ответственный', style: TextStyle(color: lightText)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedAssignee,
              items: _users.map((user) {
                return DropdownMenuItem(
                  value: user,
                  child: Text(user),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedAssignee = val),
              decoration: InputDecoration(
                filled: true,
                fillColor: lightInputBackground,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Выберите пользователя',
              ),
            ),
            const SizedBox(height: 16),

            // Описание задачи
            const Text('Описание', style: TextStyle(color: lightText)),
            const SizedBox(height: 6),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: lightInputBackground,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Введите описание задачи',
              ),
            ),
            const SizedBox(height: 24),

            // Кнопка сохранения
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop(Task(
                    status: _selectedStatus,
                    id: 4,
                    title: _titleController.text,
                    assignee: _selectedAssignee ?? 'Иван Иванов',
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Задача создана!'),
                    ),
                  );
                },
                child: const Text('Создать задачу', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
